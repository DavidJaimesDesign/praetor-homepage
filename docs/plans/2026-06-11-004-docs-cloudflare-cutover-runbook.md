---
title: "docs: add Cloudflare cutover runbook"
type: docs
status: planned
date: 2026-06-11
origin: docs/plans/2026-06-11-003-chore-production-domain-cutover.md
execution: code
---

# docs: Add Cloudflare Cutover Runbook

## Summary

Add a concrete Cloudflare cutover runbook to the repository so the remaining manual deployment work for `praetorhomesystems.com` is explicit, copyable, and safely scoped away from existing service subdomains.

---

## Problem Frame

The repository now correctly targets `praetorhomesystems.com` for GitHub Pages, but the Cloudflare-side steps are still described at a high level. The user has existing non-website subdomains under the same zone, including Tailscale-backed hosts, so the manual DNS changes should be specific enough to avoid accidental edits to unrelated records.

The goal is not to automate Cloudflare from this repo. It is to leave behind a precise, low-risk runbook that says exactly which records to add or update for the public site and which records to leave alone.

---

## Requirements

- R1. The repo should include a dedicated runbook for the Cloudflare cutover of `praetorhomesystems.com`.
- R2. The runbook should include explicit website record targets for apex and optional `www`.
- R3. The runbook should explicitly say not to alter unrelated subdomains such as `legio-13.praetorhomesystems.com`.
- R4. The README should point maintainers to the detailed runbook instead of keeping only a short summary.

---

## Key Technical Decisions

- **Runbook instead of automation:** Keep this as documentation because the user owns the Cloudflare account-side changes and may want to verify existing records before editing them.
- **Exact website record scope:** Spell out only the records relevant to the public marketing site, so home-lab/Tailscale records remain untouched.
- **Repo-local operational memory:** Store the cutover steps in-version so future deploys do not depend on chat history.

---

## Implementation Units

### U1. Cloudflare Runbook Document

- **Goal:** Create a standalone runbook for the Cloudflare cutover.
- **Requirements:** R1, R2, R3
- **Dependencies:** None
- **Files:** `docs/workflows/cloudflare-cutover.md`
- **Approach:** Document the sequence: confirm GitHub Pages domain, identify the GitHub Pages target host, add/update only the website records, verify SSL and propagation, and preserve unrelated subdomains.
- **Test scenarios:**
  - A maintainer can identify which website records affect the apex site.
  - A maintainer can identify the optional `www` path.
  - A maintainer can identify which existing non-website records must be left unchanged.
- **Verification:** The runbook reads as a complete manual execution checklist without needing prior chat context.

### U2. README Handoff Link

- **Goal:** Link the main README deployment section to the detailed Cloudflare runbook.
- **Requirements:** R4
- **Dependencies:** U1
- **Files:** `README.md`
- **Approach:** Keep the README concise and direct maintainers to the deeper runbook for the actual DNS cutover.
- **Test scenarios:**
  - A maintainer reading only the README can find the detailed Cloudflare steps immediately.
  - The README no longer needs to over-explain DNS details inline.
- **Verification:** README plus runbook form a complete deployment handoff.

---

## Scope Boundaries

### In Scope

- Cloudflare cutover documentation
- Explicit website-record guidance
- README linkage to the detailed runbook

### Deferred to Follow-Up Work

- Performing the Cloudflare changes in the dashboard
- Observing live DNS propagation
- Post-cutover redirect or Worker refinements

### Out of Scope

- Automated Cloudflare API writes
- Changing homepage content or styling
- Touching service subdomains unrelated to the public site
