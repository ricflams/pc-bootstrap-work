# First-run bootstrap script
Write-Host "Checking winget..."
$winget = Get-Command winget -ErrorAction SilentlyContinue
if (-not $winget) {
  Write-Host "Winget not found. Install App Installer from Store." -ForegroundColor Red
  exit 1
}
winget install --id SomePythonThings.WingetUIStore -e --silent --accept-package-agreements --accept-source-agreements
$manifest = Join-Path $PSScriptRoot "..\manifests\winget-packages.json"
if (Test-Path $manifest) {
  winget import -i $manifest --accept-package-agreements --accept-source-agreements
}
. "$PSScriptRoot\notes.ps1"
