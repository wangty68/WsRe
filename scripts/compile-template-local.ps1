$ErrorActionPreference = "Stop"

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$tectonic = Join-Path $repoRoot "tectonic.exe"
$templateDir = Join-Path $repoRoot "LaTeXTemplate_ActaPhysicaSinica-main"
$templateFile = Join-Path $templateDir "template.tex"

if (-not (Test-Path -LiteralPath $tectonic)) {
    Write-Host "Portable tectonic was not found at $tectonic" -ForegroundColor Yellow
    Write-Host "Place tectonic.exe in the repository root or use GitHub Actions for cloud compilation."
    exit 1
}

if (-not (Test-Path -LiteralPath $templateFile)) {
    Write-Host "Template file was not found: $templateFile" -ForegroundColor Red
    exit 1
}

Push-Location $templateDir
try {
    & $tectonic -k --keep-logs -p "template.tex"
}
finally {
    Pop-Location
}
