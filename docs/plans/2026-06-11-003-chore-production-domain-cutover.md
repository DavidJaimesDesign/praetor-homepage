---
title: "chore: configure production domain cutover"
type: chore
status: planned
date: 2026-06-11
origin: docs/plans/2026-06-11-002-chore-pages-domain-readiness.md
execution: code
---

# chore: Configure Production Domain Cutover

## Summary

Finalize the repository-side deployment setup for the chosen production hostname `praetorhomesystems.com`. The site should no longer depend on a placeholder or future repo-variable decision for its primary domain, and the documentation should explain the exact Cloudflare actions needed while preserving unrelated subdomains such as `legio-13.praetorhomesystems.com`.

---

## Problem Frame

The homepage and Pages artifact workflow are already merged, and the user has now chosen the production hostname: `praetorhomesystems.com`. The repository still models the domain as an unset variable, which is useful during planning but leaves unnecessary ambiguity during the actual cutover.

We want the repository to express the intended production domain directly while keeping the rest of the DNS namespace safe. Existing service-oriented subdomains that point to Tailscale or home-lab resources must remain out of scope and undisturbed.

---

## Requirements

- R1. The Pages artifact flow should emit `CNAME` for `praetorhomesystems.com` by default on production deploys.
- R2. The deployment docs should name `praetorhomesystems.com` explicitly as the canonical hostname.
- R3. The Cloudflare handoff docs should explain how to point the apex and optional `www` hostnames without touching unrelated subdomains.
- R4. The change should preserve the repo's static, frameworkless deployment approach.

---

## Key Technical Decisions

- **Static production default:** Treat `praetorhomesystems.com` as the default production domain in the artifact script so GitHub Pages gets a deterministic `CNAME`.
- **Optional override retained only if useful:** If keeping an override path adds negligible complexity, allow an env var to replace the default for future staging or migration scenarios.
- **Explicit DNS boundary in docs:** Call out that subdomains like `legio-13.praetorhomesystems.com` remain separate DNS records and should not be altered as part of the website cutover.

---

## Implementation Units

### U1. Production Domain in Artifact Prep

- **Goal:** Make the deploy artifact generate the correct production `CNAME` automatically.
- **Requirements:** R1, R4
- **Dependencies:** None
- **Files:** `scripts/prepare-pages-artifact.sh`, `.github/workflows/deploy.yml`
- **Approach:** Set `praetorhomesystems.com` as the default domain used by the artifact prep script. Preserve a simple override path only if it does not complicate the deploy flow.
- **Test scenarios:**
  - Running the script with no env var writes `dist/CNAME` containing `praetorhomesystems.com`.
  - Running the script with an explicit env override writes the override value instead.
  - The generated artifact still includes `.nojekyll` and the homepage assets.
- **Verification:** Local script execution proves the default and override `CNAME` behavior.

### U2. Production Cutover Documentation

- **Goal:** Document the exact canonical host and Cloudflare cutover steps.
- **Requirements:** R2, R3, R4
- **Dependencies:** U1
- **Files:** `README.md`
- **Approach:** Replace placeholder domain language with `praetorhomesystems.com`, add a recommended `www` alias path, and explicitly state that existing service subdomains should be left alone.
- **Test scenarios:**
  - A maintainer can identify the canonical host without guessing.
  - A maintainer can see which Cloudflare records affect the website and which subdomains remain untouched.
  - A maintainer can follow the steps without prior chat context.
- **Verification:** README gives a complete repo-side and Cloudflare-side handoff for the production domain cutover.

---

## Scope Boundaries

### In Scope

- Production `CNAME` default for the website
- Canonical-host and Cloudflare cutover documentation
- Clarifying the DNS boundary between the public website and other subdomains

### Deferred to Follow-Up Work

- Performing the actual Cloudflare dashboard changes
- Validating the live certificate after DNS propagates
- Adding redirects or Workers if later needed for more advanced routing

### Out of Scope

- Changing or deleting Tailscale-backed subdomains
- Reworking the site design or content
- Introducing a build framework or server-side runtime
