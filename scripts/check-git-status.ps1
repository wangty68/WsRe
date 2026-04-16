$ErrorActionPreference = "Stop"

function Get-GitCommand {
    $git = Get-Command git -ErrorAction SilentlyContinue
    if ($git) {
        return $git.Source
    }

    $candidates = @(
        "C:\Program Files\Git\cmd\git.exe",
        "C:\Program Files\Git\bin\git.exe",
        "C:\Program Files (x86)\Git\cmd\git.exe",
        "C:\Program Files (x86)\Git\bin\git.exe",
        (Join-Path $PSScriptRoot "..\tools\mingit\cmd\git.exe")
    )

    foreach ($candidate in $candidates) {
        $resolved = [System.IO.Path]::GetFullPath($candidate)
        if (Test-Path -LiteralPath $resolved) {
            return $resolved
        }
    }

    return $null
}

$gitCommand = Get-GitCommand

if (-not $gitCommand) {
    Write-Host "Git was not found." -ForegroundColor Yellow
    Write-Host "Install Git or place a portable MinGit at .\tools\mingit\cmd\git.exe, then rerun this script."
    exit 1
}

Write-Host "Using Git: $gitCommand"
& $gitCommand status --short --branch
