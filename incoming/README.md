# Incoming LaTeX Jobs

Place active LaTeX projects here.

Rules:

- Each project must live in its own subdirectory.
- Each project must expose `main.tex` as its entry file.
- Keep all required assets next to the project, such as `.bib`, images, `.sty`, and `.cls`.
- GitHub Actions compiles every `incoming/**/main.tex`.
- AI local writing should also happen here before any optional push to GitHub.
- Local compilation outputs such as `.aux`, `.log`, `.bbl`, and `.pdf` may appear here during active work.
- Keep useful review outputs if needed, but avoid treating temporary local build files as part of a reusable template.

Example:

```text
incoming/
  demo-paper/
    main.tex
    refs.bib
    figures/
      fig1.png
```
