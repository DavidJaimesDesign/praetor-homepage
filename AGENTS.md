# Praetor Homepage Agent Notes

## Project Shape

This repository is a lightweight static marketing site for Praetor Home Systems LLC.

## Container Workflow

- Use containers by default for local preview and verification.
- Prefer `docker build` and `docker run` for previewing the homepage locally.
- `compose.yaml` exists as a convenience wrapper for the same static preview flow.

## Deployment

- The site is designed for GitHub Pages.
- Keep the implementation source-driven and static unless the user explicitly asks for a framework or build step.

## Design Intent

- Preserve a premium, discreet, residential-services visual tone.
- Avoid generic SaaS language and avoid framing the offer as hobbyist self-hosting or commodity IT support.
