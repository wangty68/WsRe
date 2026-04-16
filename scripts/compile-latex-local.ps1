param(
    [Parameter(Mandatory = $true)]
    [string]$EntryFile
)

$ErrorActionPreference = "Stop"

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$tectonic = Join-Path $repoRoot "tectonic.exe"
$entryPath = [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $EntryFile))

if (-not (Test-Path -LiteralPath $tectonic)) {
    Write-Host "Portable tectonic was not found at $tectonic" -ForegroundColor Yellow
    Write-Host "Place tectonic.exe in the repository root or use GitHub Actions for cloud compilation."
    exit 1
}

if (-not (Test-Path -LiteralPath $entryPath)) {
    Write-Host "Entry file was not found: $entryPath" -ForegroundColor Red
    exit 1
}

$entryDir = Split-Path -Parent $entryPath
$entryName = Split-Path -Leaf $entryPath

Push-Location $entryDir
try {
    & $tectonic -k --keep-logs -p $entryName
}
finally {
    Pop-Location
}
