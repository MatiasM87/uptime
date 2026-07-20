param(
  [string]$OutputDir = "updates",
  [string]$SiteDir = "updates-site",
  [string[]]$Subscriptions = @()
)

$ErrorActionPreference = "Stop"

if (($Subscriptions.Count -eq 0) -and $env:AZURE_SUBSCRIPTIONS) {
  $Subscriptions = @($env:AZURE_SUBSCRIPTIONS -split "," | ForEach-Object { $_.Trim() } | Where-Object { $_ })
}

function ConvertTo-PlainText {
  param([object]$Value)
  if ($null -eq $Value) { return "" }
  return (($Value | Out-String).Trim() -replace "\r?\n", " " -replace "\s+", " ")
}

function Get-CountValue {
  param(
    [object]$Counts,
    [string[]]$Names
  )
  foreach ($name in $Names) {
    if ($null -ne $Counts -and $Counts.PSObject.Properties.Name -contains $name) {
      $value = $Counts.$name
      if ($null -ne $value) { return [int]$value }
    }
  }
  return 0
}

function HtmlEncode {
  param([object]$Value)
  return [System.Net.WebUtility]::HtmlEncode([string]$Value)
}

function Invoke-GraphQuery {
  param([string]$Query)
  $oneLineQuery = (($Query -split "\r?\n") | ForEach-Object { $_.Trim() } | Where-Object { $_ }) -join " "
  for ($attempt = 1; $attempt -le 5; $attempt++) {
    if ($Subscriptions.Count -gt 0) {
      $result = az graph query -q $oneLineQuery --subscriptions $Subscriptions --first 1000 -o json 2>&1
    } else {
      $result = az graph query -q $oneLineQuery --first 1000 -o json 2>&1
    }

    if ($LASTEXITCODE -eq 0) {
      return ($result | ConvertFrom-Json).data
    }

    $message = ($result | Out-String).Trim()
    if ($attempt -eq 5 -or $message -notmatch "429|Too Many Requests") {
      throw "Azure Resource Graph query failed: $message"
    }

    Start-Sleep -Seconds (3 * $attempt)
  }
}

function Invoke-SubscriptionMonthToDateCost {
  param([string]$SubscriptionId)

  $body = @{
    type = "ActualCost"
    timeframe = "MonthToDate"
    dataset = @{
      granularity = "None"
      aggregation = @{
        totalCost = @{
          name = "PreTaxCost"
          function = "Sum"
        }
      }
    }
  } | ConvertTo-Json -Depth 10

  $bodyPath = Join-Path ([System.IO.Path]::GetTempPath()) "azure-cost-query-$SubscriptionId.json"
  $body | Set-Content -Path $bodyPath -Encoding UTF8

  $url = "https://management.azure.com/subscriptions/$SubscriptionId/providers/Microsoft.CostManagement/query?api-version=2023-03-01"
  for ($attempt = 1; $attempt -le 5; $attempt++) {
    $result = az rest --method post --url $url --headers "Content-Type=application/json" --body "@$bodyPath" -o json 2>&1
    if ($LASTEXITCODE -eq 0) {
      $response = $result | ConvertFrom-Json
      break
    }

    $message = ($result | Out-String).Trim()
    if ($attempt -eq 5 -or $message -notmatch "429|Too Many Requests") {
      throw "Azure Cost Management query failed for subscription ${SubscriptionId}: $message"
    }

    Start-Sleep -Seconds (3 * $attempt)
  }

  $row = @($response.properties.rows)[0]

  if (-not $row) {
    return [pscustomobject]@{
      subscriptionId = $SubscriptionId
      cost = 0.0
      currency = ""
    }
  }

  return [pscustomobject]@{
    subscriptionId = $SubscriptionId
    cost = [double]$row[0]
    currency = [string]$row[1]
  }
}

function Format-Currency {
  param(
    [double]$Amount,
    [string]$Currency
  )

  if (-not $Currency) {
    return ""
  }

  return ("{0} {1:N2}" -f $Currency, $Amount)
}

New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
New-Item -ItemType Directory -Force -Path $SiteDir | Out-Null

$action1Path = Join-Path $OutputDir "action1-executive.json"
$action1Summary = if (Test-Path $action1Path) {
  Get-Content $action1Path -Raw | ConvertFrom-Json
} else {
  [pscustomobject]@{
    generatedAt = ""
    totalEndpoints = 0
    connectedEndpoints = 0
    disconnectedEndpoints = 0
    rebootPending = 0
    endpointsWithCriticalUpdates = 0
    criticalMissingUpdates = 0
    windowsEndpoints = 0
    macEndpoints = 0
  }
}

$operationsPath = Join-Path $OutputDir "azure-operations.json"
$operationsSummary = if (Test-Path $operationsPath) {
  Get-Content $operationsPath -Raw | ConvertFrom-Json
} else {
  [pscustomobject]@{
    generatedAt = ""
    automation = [pscustomobject]@{ accounts = 0; publishedRunbooks = 0; completed = 0; failed = 0; notRun = 0; runbooks = @() }
    backups = [pscustomobject]@{ protectedVMs = 0; healthy = 0; failed = 0; outsideRpo = 0; policies = @(); items = @() }
    errors = @("Operations report unavailable")
  }
}

$assessmentQuery = @"
patchassessmentresources
| where type == 'microsoft.compute/virtualmachines/patchassessmentresults'
| project
    vmName=tostring(split(id, '/')[8]),
    resourceGroup=tolower(resourceGroup),
    subscriptionId,
    location,
    osType=tostring(properties.osType),
    status=tostring(properties.status),
    rebootPending=tobool(properties.rebootPending),
    counts=properties.availablePatchCountByClassification,
    lastModified=todatetime(properties.lastModifiedDateTime),
    startedBy=tostring(properties.startedBy),
    readiness=tostring(properties.configurationStatus.vmGuestPatchReadiness.detectedVMGuestPatchSupportState),
    assessmentMode=tostring(properties.configurationStatus.assessmentModeConfiguration.status),
    patchMode=tostring(properties.configurationStatus.patchModeConfiguration.status),
    error=tostring(properties.errorDetails.message)
| order by vmName asc
"@

$patchQuery = @"
patchassessmentresources
| where type == 'microsoft.compute/virtualmachines/patchassessmentresults/softwarepatches'
| extend
    vmName=tostring(split(id, '/')[8]),
    patchName=tostring(properties.patchName),
    patchId=tostring(properties.patchId),
    patchVersion=tostring(properties.version),
    classifications=tostring(properties.classifications)
| summarize
    pendingPatches=count(),
    esmRequired=countif(patchVersion == 'UA_ESM_Required' or patchId contains 'UA_ESM_Required' or classifications contains 'Security-ESM'),
    samplePatches=make_set(patchName, 6),
    sampleClassifications=make_set(classifications, 6)
  by vmName, resourceGroup=tolower(resourceGroup), subscriptionId
"@

$vmQuery = @"
Resources
| where type =~ 'microsoft.compute/virtualmachines'
| project
    vmName=name,
    resourceGroup=tolower(resourceGroup),
    subscriptionId,
    vmId=id,
    location,
    powerState=tostring(properties.extended.instanceView.powerState.displayStatus)
"@

$assessments = @(Invoke-GraphQuery $assessmentQuery)
$patchSummaries = @(Invoke-GraphQuery $patchQuery)
$vms = @(Invoke-GraphQuery $vmQuery)

$costRows = @()
$costWarnings = @()
foreach ($subscriptionId in $Subscriptions) {
  try {
    $costRows += Invoke-SubscriptionMonthToDateCost -SubscriptionId $subscriptionId
  }
  catch {
    $costWarnings += "Cost query failed for ${subscriptionId}: $($_.Exception.Message)"
  }
}

$costCurrencies = @($costRows | Where-Object currency | Select-Object -ExpandProperty currency -Unique)
$costCurrency = if ($costCurrencies.Count -eq 1) { $costCurrencies[0] } elseif ($costCurrencies.Count -gt 1) { "mixed" } else { "" }
$monthlyAzureCost = if ($costRows.Count -gt 0 -and $costCurrency -ne "mixed") {
  [double](($costRows | Measure-Object cost -Sum).Sum)
} else {
  0.0
}
$monthlyAzureCostDisplay = if ($costRows.Count -gt 0 -and $costCurrency -ne "mixed") {
  Format-Currency -Amount $monthlyAzureCost -Currency $costCurrency
} elseif ($costCurrency -eq "mixed") {
  "Mixed currencies"
} else {
  "Unavailable"
}

$patchByKey = @{}
foreach ($patch in $patchSummaries) {
  $key = "$($patch.subscriptionId)|$($patch.resourceGroup)|$($patch.vmName)"
  $patchByKey[$key] = $patch
}

$vmByKey = @{}
foreach ($vm in $vms) {
  $key = "$($vm.subscriptionId)|$($vm.resourceGroup)|$($vm.vmName)"
  $vmByKey[$key] = $vm
}

$generatedUtc = (Get-Date).ToUniversalTime()
$generatedIso = $generatedUtc.ToString("yyyy-MM-ddTHH:mm:ssZ")
$generatedDisplay = $generatedUtc.ToString("yyyy-MM-dd HH:mm:ss 'UTC'")

$rows = foreach ($assessment in $assessments) {
  $key = "$($assessment.subscriptionId)|$($assessment.resourceGroup)|$($assessment.vmName)"
  $patch = $patchByKey[$key]
  $vm = $vmByKey[$key]
  $critical = Get-CountValue $assessment.counts @("critical", "Critical")
  $security = Get-CountValue $assessment.counts @("security", "Security")
  $other = Get-CountValue $assessment.counts @("other", "updates", "Updates", "definition", "tools", "featurePack", "servicePack", "updateRollup")
  $pending = if ($patch) { [int]$patch.pendingPatches } else { $critical + $security + $other }
  $esmRequired = if ($patch) { [int]$patch.esmRequired } else { 0 }
  $errorText = ConvertTo-PlainText $assessment.error
  $hasError = $errorText -and $errorText -notmatch "^0 error/s reported\.?$"
  $health = if ($assessment.status -ne "Succeeded") {
    "assessment_attention"
  } elseif ($hasError) {
    "assessment_warning"
  } elseif ($assessment.rebootPending) {
    "reboot_pending"
  } elseif ($pending -gt 0 -or $critical -gt 0 -or $security -gt 0) {
    "updates_pending"
  } else {
    "ok"
  }

  [pscustomobject]@{
    vm = $assessment.vmName
    resourceGroup = $assessment.resourceGroup
    subscriptionId = $assessment.subscriptionId
    location = $assessment.location
    osType = $assessment.osType
    powerState = if ($vm -and $vm.powerState) { $vm.powerState } else { "" }
    assessmentStatus = $assessment.status
    readiness = $assessment.readiness
    assessmentMode = $assessment.assessmentMode
    patchMode = $assessment.patchMode
    rebootPending = [bool]$assessment.rebootPending
    critical = $critical
    security = $security
    other = $other
    pendingPatches = $pending
    esmRequired = $esmRequired
    samplePatches = if ($patch) { @($patch.samplePatches) } else { @() }
    sampleClassifications = if ($patch) { @($patch.sampleClassifications) } else { @() }
    error = $errorText
    hasError = [bool]$hasError
    health = $health
    lastModified = if ($assessment.lastModified) { ([datetime]$assessment.lastModified).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ") } else { "" }
  }
}

$rows = @($rows | Sort-Object @{ Expression = { if ($_.health -eq "ok") { 1 } else { 0 } } }, @{ Expression = "security"; Descending = $true }, @{ Expression = "pendingPatches"; Descending = $true }, vm)

$summary = [pscustomobject]@{
  generatedAt = $generatedIso
  source = "Azure Resource Graph patchassessmentresources"
  totalVMsWithAssessment = $rows.Count
  ok = @($rows | Where-Object health -eq "ok").Count
  updatesPending = @($rows | Where-Object health -eq "updates_pending").Count
  rebootPending = @($rows | Where-Object rebootPending).Count
  assessmentWarnings = @($rows | Where-Object hasError).Count
  assessmentAttention = @($rows | Where-Object { $_.assessmentStatus -ne "Succeeded" }).Count
  esmRequiredVMs = @($rows | Where-Object { $_.esmRequired -gt 0 }).Count
  totalSecurity = ($rows | Measure-Object security -Sum).Sum
  totalCritical = ($rows | Measure-Object critical -Sum).Sum
  totalPendingPatches = ($rows | Measure-Object pendingPatches -Sum).Sum
  monthlyAzureCost = [math]::Round($monthlyAzureCost, 2)
  monthlyAzureCostCurrency = $costCurrency
  monthlyAzureCostDisplay = $monthlyAzureCostDisplay
  monthlyAzureCostScope = "MonthToDate ActualCost PreTaxCost across configured subscriptions"
  monthlyAzureCostSubscriptions = $costRows
  monthlyAzureCostWarnings = $costWarnings
  operations = $operationsSummary
  rows = $rows
}

$jsonPath = Join-Path $OutputDir "azure-vm-updates.json"
$mdPath = Join-Path $OutputDir "azure-vm-updates.md"
$htmlPath = Join-Path $SiteDir "index.html"

$summary | ConvertTo-Json -Depth 20 | Set-Content -Path $jsonPath -Encoding UTF8

$md = New-Object System.Collections.Generic.List[string]
$md.Add("# Azure VM Updates")
$md.Add("")
$md.Add("Generated: $generatedDisplay")
$md.Add("")
$md.Add("Source: Azure Resource Graph `patchassessmentresources`. This report is read-only: it does not install patches and does not reboot VMs.")
$md.Add("")
$md.Add("## Summary")
$md.Add("")
$md.Add("| Metric | Value |")
$md.Add("| --- | ---: |")
$md.Add("| VMs with patch assessment | $($summary.totalVMsWithAssessment) |")
$md.Add("| OK | $($summary.ok) |")
$md.Add("| Updates pending | $($summary.updatesPending) |")
$md.Add("| Reboot pending | $($summary.rebootPending) |")
$md.Add("| Assessment warnings/errors | $($summary.assessmentWarnings) |")
$md.Add("| Assessment not succeeded | $($summary.assessmentAttention) |")
$md.Add("| VMs with Ubuntu ESM required patches | $($summary.esmRequiredVMs) |")
$md.Add("| Costo mensual AZ acumulado | $($summary.monthlyAzureCostDisplay) |")
$md.Add("| Total security updates | $($summary.totalSecurity) |")
$md.Add("| Total critical updates | $($summary.totalCritical) |")
$md.Add("| Total pending patches listed | $($summary.totalPendingPatches) |")
$md.Add("")
$md.Add("## Automation and backups")
$md.Add("")
$md.Add("| Metric | Value |")
$md.Add("| --- | ---: |")
$md.Add("| Published runbooks | $($operationsSummary.automation.publishedRunbooks) |")
$md.Add("| Runbooks whose latest job completed | $($operationsSummary.automation.completed) |")
$md.Add("| Runbooks whose latest job failed | $($operationsSummary.automation.failed) |")
$md.Add("| Protected VMs | $($operationsSummary.backups.protectedVMs) |")
$md.Add("| Backups reported healthy by Azure | $($operationsSummary.backups.healthy) |")
$md.Add("| Backups outside their RPO threshold | $($operationsSummary.backups.outsideRpo) |")
$md.Add("")
$md.Add("## VM Detail")
$md.Add("")
$md.Add("| VM | OS | Status | Security | Critical | Other | ESM | Reboot | Last assessment | Notes |")
$md.Add("| --- | --- | --- | ---: | ---: | ---: | ---: | --- | --- | --- |")
foreach ($row in $rows) {
  $notes = if ($row.hasError) { $row.error } elseif ($row.esmRequired -gt 0) { "Ubuntu Pro/ESM likely required" } else { "" }
  if ($notes.Length -gt 140) { $notes = $notes.Substring(0, 137) + "..." }
  $md.Add("| $($row.vm) | $($row.osType) | $($row.health) | $($row.security) | $($row.critical) | $($row.other) | $($row.esmRequired) | $($row.rebootPending) | $($row.lastModified) | $($notes -replace '\|','/') |")
}
$md.Add("")
$md.Add("## Notes")
$md.Add("")
$md.Add('- `assessment_warning` usually means Azure completed the assessment but the Linux patch extension reported package-level errors. In this environment many are Ubuntu `Security-ESM` packages that require Ubuntu Pro/ESM or an OS upgrade path.')
$md.Add('- `updates_pending` means Azure has assessed pending updates. This workflow does not apply them.')
$md.Add("- Missing VMs are VMs without a recent Azure patch assessment result in Resource Graph.")
$md -join "`n" | Set-Content -Path $mdPath -Encoding UTF8

$statusClass = @{
  ok = "ok"
  updates_pending = "warn"
  reboot_pending = "reboot"
  assessment_warning = "bad"
  assessment_attention = "bad"
}

$rowHtml = foreach ($row in $rows) {
  $class = $statusClass[$row.health]
  $notes = if ($row.hasError) { $row.error } elseif ($row.esmRequired -gt 0) { "Ubuntu Pro/ESM likely required" } else { "" }
  @"
        <tr>
          <td><strong>$(HtmlEncode $row.vm)</strong><span>$(HtmlEncode $row.resourceGroup)</span></td>
          <td>$(HtmlEncode $row.osType)</td>
          <td><span class="pill $class">$(HtmlEncode $row.health)</span></td>
          <td class="num">$(HtmlEncode $row.security)</td>
          <td class="num">$(HtmlEncode $row.critical)</td>
          <td class="num">$(HtmlEncode $row.other)</td>
          <td class="num">$(HtmlEncode $row.esmRequired)</td>
          <td>$(HtmlEncode $row.rebootPending)</td>
          <td>$(HtmlEncode $row.lastModified)</td>
          <td class="notes">$(HtmlEncode $notes)</td>
        </tr>
"@
}

$runbookHtml = foreach ($runbook in @($operationsSummary.automation.runbooks)) {
  $class = switch ($runbook.lastStatus) {
    "Completed" { "ok" }
    "Failed" { "bad" }
    default { "warn" }
  }
  @"
          <div class="ops-row"><div><strong>$(HtmlEncode $runbook.name)</strong><span>$(HtmlEncode $runbook.lastEnded)</span></div><span class="pill $class">$(HtmlEncode $runbook.lastStatus)</span></div>
"@
}

$backupAlertHtml = foreach ($backup in @($operationsSummary.backups.items | Where-Object stale | Select-Object -First 12)) {
  @"
          <div class="ops-row"><div><strong>$(HtmlEncode $backup.vm)</strong><span>$(HtmlEncode $backup.lastBackupTime) · $(HtmlEncode $backup.policy)</span></div><span class="pill warn">Outside RPO</span></div>
"@
}

$backupProtectedHtml = foreach ($backup in @($operationsSummary.backups.items)) {
  $class = if ($backup.stale) { "warn" } elseif ($backup.healthy) { "ok" } else { "bad" }
  $status = if ($backup.stale) { "Outside RPO" } elseif ($backup.healthy) { "Healthy" } else { "Attention" }
  @"
          <div class="ops-row"><div><strong>$(HtmlEncode $backup.vm)</strong><span>$(HtmlEncode $backup.lastBackupTime) · $(HtmlEncode $backup.policy) · $(HtmlEncode $backup.frequency)</span></div><span class="pill $class">$status</span></div>
"@
}

$backupFrequencies = @($operationsSummary.backups.policies | Select-Object -ExpandProperty frequency -Unique) -join ", "
$retentions = @($operationsSummary.backups.policies | Select-Object -ExpandProperty retentionDays | Where-Object { $_ -gt 0 })
$retentionSummary = if ($retentions.Count -gt 0) { "$($retentions | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum)-$($retentions | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum) dias" } else { "No informado" }

$html = @"
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Azure VM Updates</title>
  <style>
    :root { --bg:#f8fafc; --panel:#fff; --line:#e2e8f0; --text:#152238; --muted:#526075; --ok:#07895b; --warn:#c77700; --bad:#c92d2d; --blue:#0053db; --soft-blue:#eaf1ff; --soft-green:#e8f7f0; --soft-amber:#fff4d6; --soft-red:#feecec; }
    * { box-sizing: border-box; }
    body { margin:0; background:var(--bg); color:var(--text); font:14px/1.5 Inter, Arial, sans-serif; }
    .wrap { width:min(1140px, calc(100vw - 40px)); margin:0 auto; }
    .nav { background:var(--panel); border-bottom:1px solid var(--line); }
    .nav-inner { align-items:center; display:flex; justify-content:space-between; min-height:64px; gap:20px; }
    .brand { align-items:center; color:var(--ok); display:flex; font:700 18px/1 Geist, Arial, sans-serif; gap:9px; text-decoration:none; }
    .brand-mark { align-items:center; background:var(--soft-green); border-radius:50%; display:inline-flex; height:30px; justify-content:center; width:30px; }
    .brand-mark svg { height:17px; width:17px; }
    .nav-links { display:flex; flex-wrap:wrap; gap:8px; }
    .nav-links a { border-radius:4px; color:var(--muted); font-size:14px; font-weight:600; padding:9px 12px; text-decoration:none; }
    .nav-links a:hover, .nav-links a.active { background:var(--soft-blue); color:var(--blue); }
    .page-head { padding:44px 0 30px; }
    h1, h2 { font-family:Geist, Arial, sans-serif; letter-spacing:0; }
    h1 { font-size:32px; line-height:1.2; margin:0; }
    p { margin:7px 0 0; color:var(--muted); }
    .generated { color:#718096; font-size:12px; }
    main { padding:0 0 48px; }
    .metrics { display:grid; grid-template-columns:repeat(7, minmax(0, 1fr)); gap:12px; margin-bottom:28px; }
    .metric { background:var(--panel); border:1px solid var(--line); border-radius:8px; min-height:108px; padding:16px; }
    .metric:hover { border-color:#b9c9e9; }
    .metric span { display:block; color:var(--muted); font-size:12px; font-weight:600; }
    .metric strong { display:block; font-family:Geist, Arial, sans-serif; font-size:25px; margin-top:8px; }
    .metric:nth-child(2) strong { color:var(--ok); }.metric:nth-child(3) strong { color:var(--warn); }.metric:nth-child(4) strong, .metric:nth-child(5) strong { color:var(--bad); }.metric:nth-child(6) strong { color:var(--ok); }
    .action1 { margin-bottom:28px; }.action1-head { align-items:baseline; display:flex; gap:12px; justify-content:space-between; margin:0 0 12px; }.action1-head h2 { font-size:20px; margin:0; }.action1-head p { font-size:12px; margin:0; }.action1 .metrics { grid-template-columns:repeat(4, minmax(0, 1fr)); margin-bottom:0; }.action1 .metric { min-height:96px; }.action1 .metric:nth-child(2) strong { color:var(--blue); }.action1 .metric:nth-child(3) strong { color:var(--bad); }.action1 .metric:nth-child(4) strong { color:var(--warn); }
    .operations { margin-bottom:28px; }.operations-grid { display:grid; grid-template-columns:1fr 1fr; gap:12px; }.ops-card { background:var(--panel); border:1px solid var(--line); border-radius:8px; padding:16px; }.ops-card h3 { font-family:Geist,Arial,sans-serif; font-size:16px; margin:0; }.ops-card > p { font-size:12px; margin:5px 0 14px; }.ops-metrics { display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:8px; margin:0 0 12px; }.ops-metric { background:#f8fafc; border:1px solid var(--line); border-radius:6px; padding:10px; }.ops-metric span { color:var(--muted); display:block; font-size:11px; font-weight:600; }.ops-metric strong { display:block; font-family:Geist,Arial,sans-serif; font-size:20px; margin-top:4px; }.ops-row { align-items:center; border-top:1px solid var(--line); display:flex; gap:10px; justify-content:space-between; padding:9px 0; }.ops-row strong { display:block; font-size:12px; }.ops-row span { color:var(--muted); font-size:11px; }.ops-row .pill { flex:none; }.ops-card details { margin-top:6px; }.ops-card summary { color:var(--blue); cursor:pointer; font-size:12px; font-weight:700; }
    .table { background:var(--panel); border:1px solid var(--line); border-radius:8px; overflow:auto; box-shadow:0 8px 28px rgba(15,23,42,.05); }
    .table-head { align-items:center; background:#f1f5f9; border-bottom:1px solid var(--line); display:flex; gap:18px; justify-content:space-between; padding:15px 16px; }
    .table-head h2 { font-size:20px; margin:0; }
    .filter { background:#fff; border:1px solid var(--line); border-radius:6px; color:var(--text); font:14px Inter,Arial,sans-serif; padding:8px 10px; width:min(100%, 270px); }
    .filter:focus { border-color:var(--blue); outline:2px solid #c8d8ff; }
    table { width:100%; min-width:1080px; border-collapse:collapse; }
    th, td { padding:10px 12px; border-bottom:1px solid var(--line); text-align:left; vertical-align:top; }
    th { position:sticky; top:0; background:#f1f5f9; color:var(--muted); font-size:12px; text-transform:uppercase; letter-spacing:.04em; }
    tbody tr:hover { background:#f8fbff; }
    td span { display:block; color:var(--muted); font-size:12px; }
    .num { text-align:right; font-variant-numeric: tabular-nums; }
    .pill { display:inline-flex; border-radius:999px; padding:3px 8px; font-size:12px; font-weight:700; }
    .pill.ok { color:var(--ok); background:var(--soft-green); }
    .pill.warn, .pill.reboot { color:var(--warn); background:var(--soft-amber); }
    .pill.bad { color:var(--bad); background:var(--soft-red); }
    .notes { max-width:360px; color:var(--muted); }
    footer { color:var(--muted); font-size:12px; margin-top:14px; }
    a { color:var(--blue); }
    @media (max-width: 900px) { .metrics, .action1 .metrics { grid-template-columns:repeat(3, minmax(0, 1fr)); } .operations-grid { grid-template-columns:1fr; } }
    @media (max-width: 620px) { .wrap { width:min(100% - 28px, 1140px); } .nav-inner { align-items:flex-start; flex-direction:column; padding:14px 0; } .page-head { padding:30px 0 24px; } h1 { font-size:26px; } .metrics, .action1 .metrics { grid-template-columns:repeat(2, minmax(0, 1fr)); } .action1-head { align-items:flex-start; flex-direction:column; } .ops-metrics { grid-template-columns:repeat(2,minmax(0,1fr)); } .table-head { align-items:stretch; flex-direction:column; } .filter { width:100%; } }
  </style>
</head>
<body>
  <header class="nav">
    <div class="wrap nav-inner">
      <a class="brand" href="/uptime/">
        <span class="brand-mark" aria-hidden="true"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 20V10"/><path d="M12 10C7 10 4 7 4 3c5 0 8 3 8 7Z"/><path d="M12 14c4 0 7-2 8-6-4 0-7 2-8 6Z"/></svg></span>
        Greenpeace Monitor
      </a>
      <nav class="nav-links" aria-label="Primary navigation">
        <a href="/uptime/">Estado</a>
        <a class="active" href="/uptime/vm-updates/">Actualizaciones</a>
        <a href="https://github.com/MatiasM87/uptime">Repositorio</a>
      </nav>
    </div>
  </header>
  <main class="wrap">
    <section class="page-head">
      <h1>Azure VM Updates</h1>
      <p>Read-only daily patch assessment report. No installs, no reboots.</p>
      <p class="generated">Generated: $(HtmlEncode $generatedDisplay)</p>
    </section>
    <section class="metrics">
      <article class="metric"><span>VMs assessed</span><strong>$($summary.totalVMsWithAssessment)</strong></article>
      <article class="metric"><span>OK</span><strong>$($summary.ok)</strong></article>
      <article class="metric"><span>Updates pending</span><strong>$($summary.updatesPending)</strong></article>
      <article class="metric"><span>Security</span><strong>$($summary.totalSecurity)</strong></article>
      <article class="metric"><span>ESM required VMs</span><strong>$($summary.esmRequiredVMs)</strong></article>
      <article class="metric"><span>Costo mensual AZ</span><strong>$(HtmlEncode $summary.monthlyAzureCostDisplay)</strong></article>
      <article class="metric"><span>Warnings</span><strong>$($summary.assessmentWarnings)</strong></article>
    </section>
    <section class="action1">
      <div class="action1-head">
        <h2>Action1 endpoint security</h2>
        <p>$(HtmlEncode $action1Summary.windowsEndpoints) Windows, $(HtmlEncode $action1Summary.macEndpoints) macOS. Data: $(HtmlEncode $action1Summary.generatedAt) · <span id="next-update">Actualizacion diaria, 09:00 ART. Calculando proxima...</span></p>
      </div>
      <div class="metrics">
        <article class="metric"><span>Managed endpoints</span><strong>$(HtmlEncode $action1Summary.totalEndpoints)</strong></article>
        <article class="metric"><span>Connected now</span><strong>$(HtmlEncode $action1Summary.connectedEndpoints)</strong></article>
        <article class="metric"><span>Critical patches pending</span><strong>$(HtmlEncode $action1Summary.criticalMissingUpdates)</strong></article>
        <article class="metric"><span>Reboots pending</span><strong>$(HtmlEncode $action1Summary.rebootPending)</strong></article>
      </div>
    </section>
    <section class="operations">
      <div class="action1-head">
        <h2>Automatizaciones y backups</h2>
        <p>Datos: $(HtmlEncode $operationsSummary.generatedAt)</p>
      </div>
      <div class="operations-grid">
        <article class="ops-card">
          <h3>Azure Automation</h3>
          <p>Ultimo job registrado por cada runbook publicado.</p>
          <div class="ops-metrics">
            <div class="ops-metric"><span>Runbooks</span><strong>$(HtmlEncode $operationsSummary.automation.publishedRunbooks)</strong></div>
            <div class="ops-metric"><span>Ultimo OK</span><strong>$(HtmlEncode $operationsSummary.automation.completed)</strong></div>
            <div class="ops-metric"><span>Ultimo fallo</span><strong>$(HtmlEncode $operationsSummary.automation.failed)</strong></div>
          </div>
$($runbookHtml -join "`n")
        </article>
        <article class="ops-card">
          <h3>Azure Backup</h3>
          <p>Politicas: $(HtmlEncode $backupFrequencies). Retencion configurada: $(HtmlEncode $retentionSummary).</p>
          <div class="ops-metrics">
            <div class="ops-metric"><span>VMs protegidas</span><strong>$(HtmlEncode $operationsSummary.backups.protectedVMs)</strong></div>
            <div class="ops-metric"><span>Azure saludable</span><strong>$(HtmlEncode $operationsSummary.backups.healthy)</strong></div>
            <div class="ops-metric"><span>Fuera de RPO</span><strong>$(HtmlEncode $operationsSummary.backups.outsideRpo)</strong></div>
          </div>
          <details>
            <summary>Ver VMs fuera de su umbral de recuperacion</summary>
$($backupAlertHtml -join "`n")
          </details>
          <details>
            <summary>Ver VMs protegidas ($($operationsSummary.backups.protectedVMs))</summary>
$($backupProtectedHtml -join "`n")
          </details>
        </article>
      </div>
    </section>
    <section class="table">
      <div class="table-head">
        <h2>Inventory Details</h2>
        <input class="filter" id="vm-filter" type="search" placeholder="Filter VMs, resource groups or status" aria-label="Filter VM inventory">
      </div>
      <table>
        <thead>
          <tr>
            <th>VM</th><th>OS</th><th>Status</th><th>Security</th><th>Critical</th><th>Other</th><th>ESM</th><th>Reboot</th><th>Last assessment</th><th>Notes</th>
          </tr>
        </thead>
        <tbody>
$($rowHtml -join "`n")
        </tbody>
      </table>
    </section>
    <footer>
      Source: Azure Resource Graph <code>patchassessmentresources</code>. JSON: <a href="./azure-vm-updates.json">azure-vm-updates.json</a>.
    </footer>
  </main>
  <script>
    (function () {
      const target = document.getElementById("next-update");
      if (!target) return;

      function updateNextRun() {
        const nowInBuenosAires = new Date(new Date().toLocaleString("en-US", { timeZone: "America/Argentina/Buenos_Aires" }));
        const nextRun = new Date(nowInBuenosAires);
        nextRun.setHours(9, 0, 0, 0);
        if (nextRun <= nowInBuenosAires) nextRun.setDate(nextRun.getDate() + 1);

        const remainingMinutes = Math.max(0, Math.ceil((nextRun - nowInBuenosAires) / 60000));
        const hours = Math.floor(remainingMinutes / 60);
        const minutes = remainingMinutes % 60;
        const when = hours === 0 ? "en " + minutes + " min" : "en " + hours + " h " + minutes + " min";
        target.textContent = "Actualizacion diaria, 09:00 ART. Proxima: " + when + ".";
      }

      updateNextRun();
      setInterval(updateNextRun, 60000);
    })();

    const filter = document.getElementById("vm-filter");
    const rows = Array.from(document.querySelectorAll("tbody tr"));
    filter.addEventListener("input", () => {
      const query = filter.value.trim().toLowerCase();
      rows.forEach((row) => { row.hidden = query && !row.textContent.toLowerCase().includes(query); });
    });
  </script>
</body>
</html>
"@

$html | Set-Content -Path $htmlPath -Encoding UTF8
Copy-Item -Path $jsonPath -Destination (Join-Path $SiteDir "azure-vm-updates.json") -Force

Write-Output "Wrote $mdPath"
Write-Output "Wrote $jsonPath"
Write-Output "Wrote $htmlPath"
