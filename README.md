# WsRe

Physics writing workspace with a reusable GitHub Actions pipeline for LaTeX.

## Structure

- `incoming/`
  Put active LaTeX jobs here. Each job should live in its own subdirectory and expose `main.tex`.
- `templates/`
  Store reusable templates here. Templates are not compiled automatically.
- `docs/`
  Contains the AI-readable operating guide.
- `scripts/`
  Local helper scripts for Git checks, local compilation, and template copying.

## Workflow behavior

- Triggers on pushes, pull requests, or manual runs
- Detects every `incoming/**/main.tex`
- Uses `latexmk + xelatex`
- Uploads generated PDFs as the artifact `latex-pdfs`

## Typical usage

1. Choose a template under `templates/`.
2. Copy it into `incoming/<project-name>/`.
3. Make sure the entry file is named `main.tex`.
4. Commit and push.
5. Download the compiled PDFs from GitHub Actions artifacts.

## Local writing mode

Use this mode when you want the AI to write LaTeX locally before any GitHub push.

1. Create or choose a project under `incoming/<project-name>/`.
2. Let the AI edit `main.tex` and any companion files in that project folder.
3. Run a local compile with `scripts/compile-latex-local.ps1`.
4. Review the generated PDF locally.
5. Push only when you want a cloud compile or a version stored on GitHub.

## Local helper commands

Check Git status:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\check-git-status.ps1
```

Copy a template into a new incoming project:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\new-latex-job.ps1 -Template acta-physica-sinica -Project demo-paper
```

Run a local compile if `tectonic.exe` exists in the repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\compile-latex-local.ps1 -EntryFile .\incoming\demo-paper\main.tex
```

## Permissions for future AI runs

Needed for local writing:

- Workspace read/write access
- Permission to run local shell commands

Needed for local compilation:

- Permission to execute `tectonic.exe` or another portable LaTeX engine in the workspace

Needed for GitHub-based compilation:

- Network access to GitHub
- A working Git client
- Valid GitHub authentication
- Push access to the target repository

## AI guide

The machine-readable operating guide is here:

- `docs/AI_LATEX_WORKFLOW.md`

## Notes

- The workflow must stay at repository root under `.github/workflows/`.
- Portable local tools such as `tectonic.exe`, MinGit, and downloaded archives are ignored and will not be committed.
