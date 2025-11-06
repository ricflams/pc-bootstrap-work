# Install-WinGet-From-GitHub.ps1
# Windows Sandbox: fetch winget release assets from GitHub and install dependencies + App Installer
# Run elevated.

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

# ---- Config ----
$WingetVersion = '1.12.350'
$Base = "https://github.com/microsoft/winget-cli/releases/download/v$WingetVersion"

$DepsUrl   = "$Base/DesktopAppInstaller_Dependencies.zip"
$BundleUrl = "$Base/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

# Exact filenames we will install (per your request / known-good versions)
$UwpDesktopAppx = 'x64/Microsoft.VCLibs.140.00.UWPDesktop_14.0.33728.0_x64.appx'
$VCLibsAppx     = 'x64/Microsoft.VCLibs.140.00_14.0.33519.0_x64.appx'

# ---- Paths ----
$Work = Join-Path $env:TEMP "winget-$WingetVersion"
$DepsZip   = Join-Path $Work 'DesktopAppInstaller_Dependencies.zip'
$Bundle    = Join-Path $Work 'Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle'
$DepsDir   = Join-Path $Work 'deps'

# ---- Helpers ----
function Invoke-Download([string]$Url, [string]$OutPath) {
    New-Item -ItemType Directory -Force -Path (Split-Path $OutPath) | Out-Null
    # Try normal TLS first; if Zscaler blocks, retry with -k. Fail if still blocked.
    $args = @('-fL','--retry','3','--retry-delay','2', $Url, '-o', $OutPath)
    $p = Start-Process -FilePath 'curl.exe' -ArgumentList $args -NoNewWindow -Wait -PassThru
    if ($p.ExitCode -ne 0 -or -not (Test-Path $OutPath) -or (Get-Item $OutPath).Length -lt 1MB) {
        Remove-Item $OutPath -ErrorAction SilentlyContinue
        $args = @('-fL','-k','--retry','3','--retry-delay','2', $Url, '-o', $OutPath)
        $p = Start-Process -FilePath 'curl.exe' -ArgumentList $args -NoNewWindow -Wait -PassThru
        if ($p.ExitCode -ne 0 -or -not (Test-Path $OutPath) -or (Get-Item $OutPath).Length -lt 1MB) {
            throw "Download failed: $Url (exit $($p.ExitCode))"
        }
    }
}

# ---- Do work ----
New-Item -ItemType Directory -Force -Path $Work | Out-Null

Write-Host "Downloading dependencies zip..."
Invoke-Download $DepsUrl $DepsZip

Write-Host "Downloading App Installer bundle..."
Invoke-Download $BundleUrl $Bundle

Write-Host "Extracting dependencies..."
if (Test-Path $DepsDir) { Remove-Item $DepsDir -Recurse -Force }
Expand-Archive -Path $DepsZip -DestinationPath $DepsDir

$UwpPath = Join-Path $DepsDir $UwpDesktopAppx
$VcPath  = Join-Path $DepsDir $VCLibsAppx

if (-not (Test-Path $UwpPath)) { throw "Missing expected file: $UwpDesktopAppx" }
if (-not (Test-Path $VcPath))  { throw "Missing expected file: $VCLibsAppx" }
if (-not (Test-Path $Bundle))  { throw "Missing App Installer bundle at $Bundle" }

Write-Host "Installing UwpDesktop..."
Add-AppxPackage $UwpPath

Write-Host "Installing VCLibs..."
Add-AppxPackage $VcPath

Write-Host "Installing WinGet..."
Add-AppxPackage $Bundle

Write-Host "Verifying winget..."
$winget = Join-Path $env:LOCALAPPDATA 'Microsoft\WindowsApps\winget.exe'
if (Test-Path $winget) {
    & $winget --info
    Write-Host "`nwinget is installed." -ForegroundColor Green
} else {
    Write-Warning "winget.exe not found on PATH yet. Open a new PowerShell window or call the full path once:"
    Write-Host "  `"$winget`" --info"
}
