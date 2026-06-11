---
title: "chore: prepare Pages deployment and domain handoff"
type: chore
status: planned
date: 2026-06-11
origin: docs/plans/2026-06-11-001-feat-praetor-homepage.md
execution: code
---

# chore: Prepare Pages Deployment and Domain Handoff

## Summary

Harden the existing Praetor homepage deployment path so GitHub Pages receives a clean static artifact and the repository can support a custom domain without another code change. The result should reduce the remaining post-merge work to two operator inputs: authenticating `gh` locally and choosing the final hostname for Cloudflare.

---

## Problem Frame

The homepage implementation is already built and merged upstream, but the post-merge operational path still has friction:

- The current workflow uploads the repository root directly instead of a deliberately prepared artifact.
- There is no built-in mechanism for supplying a custom domain at deploy time without editing tracked files again.
- The final Cloudflare routing step still needs a chosen hostname and live authenticated GitHub access.

This follow-up should make the repository deployment-ready while preserving the static, frameworkless shape of the project.

---

## Requirements

- R1. GitHub Pages deployment should upload a clean static artifact directory rather than the entire repository root.
- R2. The deployment flow should optionally emit a `CNAME` file when a domain value is supplied through configuration.
- R3. Local documentation should explain how to provide the custom-domain value and what remains to do in GitHub Pages and Cloudflare.
- R4. The implementation must preserve the repo's simple static-site structure and avoid introducing a heavy build system.

---

## Key Technical Decisions

- **Prepared artifact over raw repo upload:** Generate a small deploy directory containing only the site assets and Pages metadata files.
- **Environment-driven custom domain support:** Read the domain from a GitHub Actions variable so enabling a hostname does not require another commit.
- **Shell script for portability:** Use a tiny repo-local shell script instead of a JS build step to keep the workflow transparent and static-host friendly.

---

## Implementation Units

### U1. Pages Artifact Preparation

- **Goal:** Add a small deploy-prep script that assembles a clean Pages artifact.
- **Requirements:** R1, R2, R4
- **Dependencies:** None
- **Files:** `scripts/prepare-pages-artifact.sh`, `.gitignore`, `.github/workflows/deploy.yml`
- **Approach:** Copy the homepage assets into `dist/`, write `.nojekyll`, and write `CNAME` only when the configured domain variable is non-empty.
- **Test scenarios:**
  - Running the script without a domain creates `dist/` with the static assets and `.nojekyll`, but no `CNAME`.
  - Running the script with a domain creates a `CNAME` file containing the exact hostname.
  - The workflow uploads `dist/` instead of the repository root.
- **Verification:** The script can be run locally and the resulting `dist/` contains only the intended deploy files.

### U2. Deployment and Domain Documentation

- **Goal:** Document the remaining post-merge operator steps for Pages activation, domain configuration, and Cloudflare routing.
- **Requirements:** R3, R4
- **Dependencies:** U1
- **Files:** `README.md`
- **Approach:** Add concise deployment notes covering `gh auth login`, the GitHub Actions variable name for the domain, the Pages setting that should be enabled, and the final Cloudflare DNS/SSL checklist.
- **Test scenarios:**
  - A maintainer can tell where to put the custom domain value.
  - A maintainer can tell which repo setting to enable for Pages.
  - A maintainer can tell which remaining Cloudflare actions are still manual.
- **Verification:** README provides a complete handoff without requiring prior chat context.

---

## Scope Boundaries

### In Scope

- Static artifact preparation for Pages
- Optional `CNAME` generation
- Deployment and routing handoff documentation

### Deferred to Follow-Up Work

- Authenticating `gh` locally
- Choosing the final production hostname
- Making Cloudflare account-side changes

### Out of Scope

- Rebuilding the visual homepage
- Introducing a frontend framework or asset pipeline
- Managing Cloudflare resources without confirmed account access and hostname
