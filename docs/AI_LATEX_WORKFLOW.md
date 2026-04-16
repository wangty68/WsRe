# AI LaTeX Workflow Guide

This file is the machine-readable operating guide for AI agents that work in this repository.

## Goal

Use this repository as a general LaTeX compilation workspace backed by GitHub Actions.

## Repository contract

- Active jobs live under `incoming/`.
- Reusable templates live under `templates/`.
- The GitHub Actions workflow compiles every `incoming/**/main.tex`.
- The workflow must remain at `.github/workflows/latex.yml`.
- Compiled PDFs are uploaded as the artifact `latex-pdfs`.

## Standard operating procedure

1. Inspect `incoming/`, `templates/`, and `.github/workflows/latex.yml`.
2. If the user provides a new LaTeX project, place it under `incoming/<project-name>/`.
3. Ensure the project entry file is named `main.tex`.
4. Ensure all required companion files are present, including `.bib`, images, `.sty`, `.cls`, `.bst`, fonts, and data files.
5. If starting from a stored template, copy from `templates/<template-name>/` into `incoming/<project-name>/`.
6. Do not edit files inside `templates/` unless the user explicitly asks to modify or add a template.
7. Commit and push changes to trigger GitHub Actions.
8. Check the latest GitHub Actions run and report success, failure, artifact name, and relevant logs.

## Local writing mode

Use local writing mode when the user wants the AI to draft or edit LaTeX in the workspace before pushing anything to GitHub.

Standard flow:

1. Create or reuse `incoming/<project-name>/`.
2. Write or edit `main.tex` and all required companion files locally.
3. Run `scripts/compile-latex-local.ps1 -EntryFile <path-to-main.tex>` if local compilation is requested.
4. Report local compile results and remaining warnings.
5. Push only if the user wants remote compilation, backup, or artifact generation from GitHub Actions.

## Naming rules

- Use lowercase and hyphen-separated names for template folders.
- Use descriptive and stable names for incoming project folders.
- Prefer `main.tex` as the only supported entry filename for active jobs.

## When adding a new template

- Store it under `templates/<template-name>/`.
- Keep the original license and README if provided.
- Remove temporary build artifacts such as `.aux`, `.log`, `.blg`, `.fdb_latexmk`, and similar files unless the user explicitly asks to keep them.
- Keep a sample `template.pdf` only if it is useful as a visual reference.

## When compiling locally

- Use `scripts/compile-latex-local.ps1 -EntryFile <path-to-main.tex>`.
- Local compilation requires `tectonic.exe` in the repository root.
- GitHub Actions remains the authoritative compile path for final verification.
- Local compilation may leave `.aux`, `.bbl`, `.blg`, `.log`, and `.pdf` files inside the active project folder.
- These local outputs are acceptable in `incoming/` when they help review, but should be managed intentionally before broad template reuse.

## Local helper scripts

- `scripts/check-git-status.ps1`
  Detects available Git and prints repository status.
- `scripts/new-latex-job.ps1`
  Copies a stored template into `incoming/<project-name>/`.
- `scripts/compile-latex-local.ps1`
  Runs a local compilation for a specific entry file.

## Things to avoid

- Do not place active projects directly in the repository root.
- Do not rely on template directories being compiled automatically.
- Do not rename `.github/workflows/latex.yml` without also updating repository documentation.
- Do not assume arbitrary `.tex` files are entry files; only `main.tex` under `incoming/` is part of the standard contract.

## Required permissions for future AI runs

Minimum useful permissions:

- Read and write access to the repository workspace.
- Permission to run local shell commands.
- Network access to GitHub so the agent can inspect Actions runs and artifacts when needed.

Needed for local writing only:

- No GitHub authentication is required.
- No push permission is required.

Needed only when pushing changes:

- A working Git client in PATH or at `tools/mingit/`.
- GitHub authentication in the browser or credential manager.
- Permission to push to the target repository.

Needed only for local compilation:

- Permission to execute `tectonic.exe` or another portable LaTeX engine in the workspace.

## Success criteria

A task is complete when:

- The target LaTeX project is stored under `incoming/<project-name>/`.
- The project exposes `main.tex`.
- The repository is committed and pushed if remote compilation is requested.
- The latest GitHub Actions run finishes successfully.
- The resulting PDF is available in the `latex-pdfs` artifact.
