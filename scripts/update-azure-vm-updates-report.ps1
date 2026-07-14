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
  if ($Subscriptions.Count -gt 0) {
    return (az graph query -q $oneLineQuery --subscriptions $Subscriptions --first 1000 -o json | ConvertFrom-Json).data
  }
  return (az graph query -q $oneLineQuery --first 1000 -o json | ConvertFrom-Json).data
}

New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
New-Item -ItemType Directory -Force -Path $SiteDir | Out-Null

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
$md.Add("| Total security updates | $($summary.totalSecurity) |")
$md.Add("| Total critical updates | $($summary.totalCritical) |")
$md.Add("| Total pending patches listed | $($summary.totalPendingPatches) |")
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

$html = @"
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Azure VM Updates</title>
  <style>
    :root { --bg:#f6f8fa; --panel:#fff; --line:#d8dee4; --text:#24292f; --muted:#57606a; --ok:#1a7f37; --warn:#9a6700; --bad:#cf222e; --blue:#0969da; }
    * { box-sizing: border-box; }
    body { margin:0; background:var(--bg); color:var(--text); font:14px/1.45 -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif; }
    header { background:var(--panel); border-bottom:1px solid var(--line); }
    .wrap { width:min(1320px, calc(100vw - 32px)); margin:0 auto; }
    .top { display:flex; justify-content:space-between; gap:24px; padding:24px 0 18px; }
    h1 { margin:0; font-size:26px; }
    p { margin:6px 0 0; color:var(--muted); }
    main { padding:18px 0 36px; }
    .metrics { display:grid; grid-template-columns:repeat(6, minmax(0, 1fr)); gap:10px; margin-bottom:14px; }
    .metric { background:var(--panel); border:1px solid var(--line); border-radius:8px; padding:13px; }
    .metric span { display:block; color:var(--muted); font-size:12px; text-transform:uppercase; letter-spacing:.04em; }
    .metric strong { display:block; margin-top:6px; font-size:24px; }
    .table { background:var(--panel); border:1px solid var(--line); border-radius:8px; overflow:auto; }
    table { width:100%; min-width:1080px; border-collapse:collapse; }
    th, td { padding:10px 12px; border-bottom:1px solid var(--line); text-align:left; vertical-align:top; }
    th { position:sticky; top:0; background:#f0f3f6; font-size:12px; text-transform:uppercase; letter-spacing:.04em; }
    td span { display:block; color:var(--muted); font-size:12px; }
    .num { text-align:right; font-variant-numeric: tabular-nums; }
    .pill { display:inline-flex; border-radius:999px; padding:3px 8px; font-size:12px; font-weight:700; }
    .pill.ok { color:var(--ok); background:#dafbe1; }
    .pill.warn, .pill.reboot { color:var(--warn); background:#fff8c5; }
    .pill.bad { color:var(--bad); background:#ffebe9; }
    .notes { max-width:360px; color:var(--muted); }
    footer { color:var(--muted); font-size:12px; margin-top:12px; }
    a { color:var(--blue); }
    @media (max-width: 900px) { .top { display:block; } .metrics { grid-template-columns:repeat(2, minmax(0, 1fr)); } }
  </style>
</head>
<body>
  <header>
    <div class="wrap top">
      <div>
        <h1>Azure VM Updates</h1>
        <p>Read-only daily patch assessment report. No installs, no reboots.</p>
      </div>
      <p>Generated: $(HtmlEncode $generatedDisplay)</p>
    </div>
  </header>
  <main class="wrap">
    <section class="metrics">
      <article class="metric"><span>VMs assessed</span><strong>$($summary.totalVMsWithAssessment)</strong></article>
      <article class="metric"><span>OK</span><strong>$($summary.ok)</strong></article>
      <article class="metric"><span>Updates pending</span><strong>$($summary.updatesPending)</strong></article>
      <article class="metric"><span>Security</span><strong>$($summary.totalSecurity)</strong></article>
      <article class="metric"><span>ESM required VMs</span><strong>$($summary.esmRequiredVMs)</strong></article>
      <article class="metric"><span>Warnings</span><strong>$($summary.assessmentWarnings)</strong></article>
    </section>
    <section class="table">
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
</body>
</html>
"@

$html | Set-Content -Path $htmlPath -Encoding UTF8
Copy-Item -Path $jsonPath -Destination (Join-Path $SiteDir "azure-vm-updates.json") -Force

Write-Output "Wrote $mdPath"
Write-Output "Wrote $jsonPath"
Write-Output "Wrote $htmlPath"
