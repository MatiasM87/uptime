param(
  [string]$OutputDir = "updates",
  [string]$SiteDir = "updates-site",
  [string[]]$Subscriptions = @()
)

$ErrorActionPreference = "Stop"

if (($Subscriptions.Count -eq 0) -and $env:AZURE_SUBSCRIPTIONS) {
  $Subscriptions = @($env:AZURE_SUBSCRIPTIONS -split "," | ForEach-Object { $_.Trim() } | Where-Object { $_ })
}

function Invoke-AzJson {
  param([string[]]$Arguments)

  $result = & az @Arguments --only-show-errors 2>$null
  if ($LASTEXITCODE -ne 0) {
    throw (($result | Out-String).Trim())
  }
  if (-not $result) { return $null }
  return ($result | ConvertFrom-Json)
}

function ConvertTo-IsoUtc {
  param([object]$Value)
  if (-not $Value) { return "" }
  return ([datetime]$Value).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
}

function ConvertTo-Days {
  param([object]$Value, [double]$Default = 0)
  if (-not $Value) { return $Default }
  try { return [timespan]::Parse([string]$Value).TotalDays } catch { return $Default }
}

function Get-FrequencyLabel {
  param([object]$Value)
  $days = ConvertTo-Days $Value
  if ($days -eq 1) { return "Diario" }
  if ($days -gt 0 -and $days -eq [math]::Round($days)) { return "Cada $([int]$days) dias" }
  if ($days -gt 0) { return "Cada $([math]::Round($days * 24)) horas" }
  return "No informado"
}

New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
New-Item -ItemType Directory -Force -Path $SiteDir | Out-Null

$generatedUtc = (Get-Date).ToUniversalTime()
$errors = New-Object System.Collections.Generic.List[string]

$automationAccounts = @()
foreach ($subscription in $Subscriptions) {
  try {
    $accounts = @(Invoke-AzJson @("resource", "list", "--subscription", $subscription, "--resource-type", "Microsoft.Automation/automationAccounts", "--query", "[].{name:name,resourceGroup:resourceGroup}", "-o", "json"))
    foreach ($account in $accounts) {
      $automationAccounts += [pscustomobject]@{
        subscriptionId = $subscription
        name = $account.name
        resourceGroup = $account.resourceGroup
      }
    }
  } catch {
    $errors.Add("Automation account discovery for $subscription failed: $($_.Exception.Message)")
  }
}

$runbooks = @()
foreach ($account in $automationAccounts) {
  try {
    $published = @(Invoke-AzJson @("automation", "runbook", "list", "--subscription", $account.subscriptionId, "--resource-group", $account.resourceGroup, "--automation-account-name", $account.name, "-o", "json") | Where-Object { $_.state -eq "Published" })
    $jobs = @(Invoke-AzJson @("automation", "job", "list", "--subscription", $account.subscriptionId, "--resource-group", $account.resourceGroup, "--automation-account-name", $account.name, "-o", "json"))
    $latestByName = @{}
    foreach ($job in ($jobs | Sort-Object { [datetime]$_.lastModifiedTime } -Descending)) {
      $name = [string]$job.runbook.name
      if ($name -and -not $latestByName.ContainsKey($name)) { $latestByName[$name] = $job }
    }

    foreach ($runbook in $published) {
      $job = $latestByName[[string]$runbook.name]
      $runbooks += [pscustomobject]@{
        account = $account.name
        name = [string]$runbook.name
        state = [string]$runbook.state
        lastStatus = if ($job) { [string]$job.status } else { "NotRun" }
        lastStarted = if ($job) { ConvertTo-IsoUtc $job.startTime } else { "" }
        lastEnded = if ($job) { ConvertTo-IsoUtc $job.endTime } else { "" }
      }
    }
  } catch {
    $errors.Add("Runbook status for $($account.name) failed: $($_.Exception.Message)")
  }
}
$runbooks = @($runbooks | Sort-Object name)

$backupQuery = @"
recoveryservicesresources
| where type =~ 'microsoft.recoveryservices/vaults/backupfabrics/protectioncontainers/protecteditems'
| project vm=tostring(properties.friendlyName), resourceGroup, subscriptionId, lastBackupStatus=tostring(properties.lastBackupStatus), lastBackupTime=todatetime(properties.lastBackupTime), healthStatus=tostring(properties.healthStatus), protectionStatus=tostring(properties.protectionStatus), policy=tostring(properties.policyName), frequency=tostring(properties.configuredRPGenerationFrequency), retention=tostring(properties.configuredMaximumRetention), rpoThreshold=tostring(properties.rpoWarningThresholdInPrimaryRegion)
"@

$backupItems = @()
try {
  $oneLineQuery = (($backupQuery -split "\r?\n") | ForEach-Object { $_.Trim() } | Where-Object { $_ }) -join " "
  $result = Invoke-AzJson (@("graph", "query", "-q", $oneLineQuery, "--subscriptions") + $Subscriptions + @("--first", "1000", "-o", "json"))
  $backupItems = @($result.data | ForEach-Object {
    $lastBackup = if ($_.lastBackupTime) { ([datetime]$_.lastBackupTime).ToUniversalTime() } else { $null }
    $rpoDays = ConvertTo-Days $_.rpoThreshold 2
    $healthy = $_.lastBackupStatus -eq "Completed" -and $_.healthStatus -eq "Passed" -and $_.protectionStatus -eq "Healthy"
    $stale = -not $lastBackup -or $lastBackup -lt $generatedUtc.AddDays(-$rpoDays)
    [pscustomobject]@{
      vm = [string]$_.vm
      resourceGroup = [string]$_.resourceGroup
      subscriptionId = [string]$_.subscriptionId
      lastBackupStatus = [string]$_.lastBackupStatus
      lastBackupTime = if ($lastBackup) { $lastBackup.ToString("yyyy-MM-ddTHH:mm:ssZ") } else { "" }
      healthStatus = [string]$_.healthStatus
      protectionStatus = [string]$_.protectionStatus
      policy = [string]$_.policy
      frequency = Get-FrequencyLabel $_.frequency
      retentionDays = [math]::Round((ConvertTo-Days $_.retention), 0)
      rpoThresholdDays = [math]::Round($rpoDays, 2)
      stale = [bool]$stale
      healthy = [bool]$healthy
    }
  })
} catch {
  $errors.Add("Backup status query failed: $($_.Exception.Message)")
}
$backupItems = @($backupItems | Sort-Object @{ Expression = "stale"; Descending = $true }, @{ Expression = "lastBackupTime" })
$backupPolicies = @($backupItems | Group-Object policy | ForEach-Object {
  $sample = $_.Group | Select-Object -First 1
  [pscustomobject]@{
    name = $_.Name
    protectedVMs = $_.Count
    frequency = $sample.frequency
    retentionDays = $sample.retentionDays
  }
} | Sort-Object name)

$report = [pscustomobject]@{
  generatedAt = $generatedUtc.ToString("yyyy-MM-ddTHH:mm:ssZ")
  automation = [pscustomobject]@{
    accounts = $automationAccounts.Count
    publishedRunbooks = $runbooks.Count
    completed = @($runbooks | Where-Object lastStatus -eq "Completed").Count
    failed = @($runbooks | Where-Object lastStatus -eq "Failed").Count
    notRun = @($runbooks | Where-Object lastStatus -eq "NotRun").Count
    runbooks = $runbooks
  }
  backups = [pscustomobject]@{
    protectedVMs = $backupItems.Count
    healthy = @($backupItems | Where-Object healthy).Count
    failed = @($backupItems | Where-Object { $_.lastBackupStatus -ne "Completed" -or $_.healthStatus -ne "Passed" -or $_.protectionStatus -ne "Healthy" }).Count
    outsideRpo = @($backupItems | Where-Object stale).Count
    policies = $backupPolicies
    items = $backupItems
  }
  errors = @($errors)
}

$outputPath = Join-Path $OutputDir "azure-operations.json"
$report | ConvertTo-Json -Depth 20 | Set-Content -Path $outputPath -Encoding UTF8
Copy-Item -Path $outputPath -Destination (Join-Path $SiteDir "azure-operations.json") -Force

Write-Output "Wrote $outputPath"
