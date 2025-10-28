$root = Join-Path $PSScriptRoot '..'
$stateDir = Join-Path $root "state\$(Get-Date -Format yyyyMMdd-HHmmss)"
New-Item -ItemType Directory -Path $stateDir -Force | Out-Null
winget export -o (Join-Path $stateDir 'winget-packages.json')
winget list | Out-File -FilePath (Join-Path $stateDir 'winget-list.txt') -Encoding utf8
