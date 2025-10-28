# Lightweight logging helpers and profile hook
$Global:NotesFile = Join-Path $PSScriptRoot "..\notes\MACHINE_NOTES.md"
function note {
  param([Parameter(Mandatory=$true, ValueFromRemainingArguments=$true)][string]$Text)
  $timestamp = (Get-Date).ToUniversalTime().ToString("u")
  $line = "$timestamp $Text"
  Add-Content -Path $Global:NotesFile -Value $line
  Write-Host "Appended to MACHINE_NOTES.md:" -ForegroundColor Green
  Write-Host "  $line"
}
