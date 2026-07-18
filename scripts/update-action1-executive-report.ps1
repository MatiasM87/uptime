param(
  [string]$OutputDir = "updates",
  [string]$SiteDir = "updates-site"
)

$ErrorActionPreference = "Stop"

if (-not $env:ACTION1_CLIENT_ID -or -not $env:ACTION1_CLIENT_SECRET) {
  throw "ACTION1_CLIENT_ID and ACTION1_CLIENT_SECRET are required."
}

function Get-CountValue {
  param([object]$Object, [string]$Name)
  if ($null -ne $Object -and $Object.PSObject.Properties.Name -contains $Name -and $null -ne $Object.$Name) {
    return [int]$Object.$Name
  }
  return 0
}

function Get-Action1Paged {
  param([string]$Path)

  $items = @()
  $from = 0
  $limit = 200
  do {
    $separator = if ($Path.Contains("?")) { "&" } else { "?" }
    $page = Invoke-RestMethod -Headers $headers -Uri "$apiBaseUrl/$Path$separator`from=$from&limit=$limit"
    $pageItems = @($page.items)
    $items += $pageItems
    $from += $pageItems.Count
    $total = if ($page.total_items) { [int]$page.total_items } else { $items.Count }
  } while ($pageItems.Count -gt 0 -and $items.Count -lt $total)
  return @($items)
}

New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
New-Item -ItemType Directory -Force -Path $SiteDir | Out-Null

$apiBaseUrl = "https://app.action1.com/api/3.0"
$tokenResponse = Invoke-RestMethod -Method Post -Uri "$apiBaseUrl/oauth2/token" -ContentType "application/x-www-form-urlencoded" -Body @{
  client_id = $env:ACTION1_CLIENT_ID
  client_secret = $env:ACTION1_CLIENT_SECRET
}
$headers = @{ Authorization = "Bearer $($tokenResponse.access_token)" }

$endpoints = Get-Action1Paged -Path "endpoints/managed/all?fields=*"
$generatedAt = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")

$summary = [pscustomobject]@{
  generatedAt = $generatedAt
  totalEndpoints = $endpoints.Count
  connectedEndpoints = @($endpoints | Where-Object { $_.status -eq "Connected" }).Count
  disconnectedEndpoints = @($endpoints | Where-Object { $_.status -ne "Connected" }).Count
  rebootPending = @($endpoints | Where-Object { $_.reboot_required -eq "Yes" }).Count
  endpointsWithCriticalUpdates = @($endpoints | Where-Object { (Get-CountValue $_.missing_updates "critical") -gt 0 }).Count
  criticalMissingUpdates = [int](($endpoints | ForEach-Object { Get-CountValue $_.missing_updates "critical" } | Measure-Object -Sum).Sum)
  windowsEndpoints = @($endpoints | Where-Object { $_.platform -eq "Windows" }).Count
  macEndpoints = @($endpoints | Where-Object { $_.platform -eq "Mac" }).Count
  source = "Action1 endpoint inventory, update and vulnerability status"
}

$outputPath = Join-Path $OutputDir "action1-executive.json"
$summary | ConvertTo-Json -Depth 10 | Set-Content -Path $outputPath -Encoding UTF8
Copy-Item -Path $outputPath -Destination (Join-Path $SiteDir "action1-executive.json") -Force

Write-Output "Wrote $outputPath"
