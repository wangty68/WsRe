# WsRe

Physics writing workspace with a ready-to-run GitHub Actions pipeline for LaTeX.

## Included setup

- Acta Physica Sinica LaTeX template in `LaTeXTemplate_ActaPhysicaSinica-main/`
- GitHub Actions workflow in `.github/workflows/latex.yml`
- Local helper scripts in `scripts/`

## What the workflow does

- Triggers on pushes, pull requests, or manual runs
- Compiles `LaTeXTemplate_ActaPhysicaSinica-main/template.tex`
- Uses `latexmk + xelatex`
- Uploads the generated PDF as the artifact `acta-physica-sinica-pdf`

## Repository structure

```text
.
|-- .github/
|   `-- workflows/
|       `-- latex.yml
|-- LaTeXTemplate_ActaPhysicaSinica-main/
|   |-- template.tex
|   |-- acta_physica_sinica.sty
|   |-- acta_physica_sinica.bst
|   |-- bibfile.bib
|   `-- figures/
`-- scripts/
```

## Local checks

Check Git status:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\check-git-status.ps1
```

Run a local smoke test if `tectonic.exe` exists in the repository root:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\compile-template-local.ps1
```

## Notes

- The workflow must stay at repository root under `.github/workflows/`.
- Portable local tools such as `tectonic.exe`, MinGit, and downloaded archives are ignored and will not be committed.
