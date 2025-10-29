# Sandbox-Run-Setup.ps1
# Runs at sandbox startup

# Optional: install winget from mapped assets
$wingetBundle = 'C:\pc-bootstrap-assets\AppInstaller.msixbundle'
if (Test-Path $wingetBundle) {
    Write-Host "Installing App Installer (winget)..." -ForegroundColor Yellow
    Add-AppxPackage $wingetBundle
}

# Run main bootstrap
Set-Location 'C:\pc-bootstrap-work\bootstrap'
Write-Host "Running setup.ps1..." -ForegroundColor Cyan
.\setup.ps1

Write-Host "`n--- Finished. Press Enter to close ---" -ForegroundColor Green
Read-Host
