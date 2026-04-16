param(
    [Parameter(Mandatory = $true)]
    [string]$Template,

    [Parameter(Mandatory = $true)]
    [string]$Project
)

$ErrorActionPreference = "Stop"

$repoRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot ".."))
$templateDir = Join-Path $repoRoot ("templates\" + $Template)
$projectDir = Join-Path $repoRoot ("incoming\" + $Project)

if (-not (Test-Path -LiteralPath $templateDir)) {
    Write-Host "Template not found: $templateDir" -ForegroundColor Red
    exit 1
}

if (Test-Path -LiteralPath $projectDir) {
    Write-Host "Project already exists: $projectDir" -ForegroundColor Red
    exit 1
}

Copy-Item -LiteralPath $templateDir -Destination $projectDir -Recurse

$templateMain = Join-Path $projectDir "template.tex"
$projectMain = Join-Path $projectDir "main.tex"
if (Test-Path -LiteralPath $templateMain) {
    Move-Item -LiteralPath $templateMain -Destination $projectMain
}

$cleanupPatterns = @("*.aux", "*.bbl", "*.bcf", "*.blg", "*.fdb_latexmk", "*.fls", "*.log", "*.out", "*.run.xml", "*.synctex.gz", "*.toc", "*.xdv")
foreach ($pattern in $cleanupPatterns) {
    Get-ChildItem -Path $projectDir -Recurse -Filter $pattern -File -ErrorAction SilentlyContinue | Remove-Item -Force
}

Write-Host "Created project at: $projectDir"
Write-Host "Entry file: $projectMain"
