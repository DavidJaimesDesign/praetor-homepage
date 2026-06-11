# Cloudflare Cutover Runbook

This runbook covers the public website cutover for `praetorhomesystems.com` to GitHub Pages.

It does **not** cover private or service-oriented subdomains such as:

- `legio-13.praetorhomesystems.com`
- any Tailscale-backed hostnames
- any internal/home-lab records unrelated to the public website

Leave those records unchanged.

## Goal

Route the public marketing site for `praetorhomesystems.com` to the GitHub Pages deployment produced by this repository.

## Before You Change DNS

1. Confirm the GitHub Pages workflow has deployed from `main`.
2. In the GitHub repository Pages settings, confirm the custom domain is set to `praetorhomesystems.com`.
3. Note the GitHub Pages target hostname shown by GitHub for the site.

## Records To Touch

Only touch the records for:

- `praetorhomesystems.com`
- optionally `www.praetorhomesystems.com`

Do not modify unrelated subdomains.

## Recommended DNS Shape

### Apex Domain

For the apex website host `praetorhomesystems.com`:

1. Update or create only the website record for the apex host.
2. Point it at the GitHub Pages target using GitHub's current recommended apex-domain setup.
3. If using a `CNAME` at the apex through Cloudflare flattening, verify it resolves to the GitHub Pages target correctly.

### Optional `www`

If you want `www.praetorhomesystems.com` available:

1. Create `www` as a `CNAME` to the same GitHub Pages target.
2. Choose one canonical host:
   - `praetorhomesystems.com`, or
   - `www.praetorhomesystems.com`
3. If both resolve, redirect the non-canonical host to the canonical one.

## Cloudflare Settings

1. Keep SSL/TLS enabled.
2. Make sure the final hostname can complete HTTPS successfully after DNS propagation.
3. If Cloudflare proxying introduces issues during first validation, compare behavior with the record proxied versus DNS-only and keep the working configuration.

## Verification Checklist

- GitHub Pages shows `praetorhomesystems.com` as the custom domain.
- DNS for `praetorhomesystems.com` resolves to the GitHub Pages site.
- HTTPS works for the canonical host.
- Optional `www` behavior matches your chosen canonical host strategy.
- Existing non-website subdomains such as `legio-13.praetorhomesystems.com` still resolve exactly as before.

## Rollback Boundary

If the public website cutover behaves unexpectedly:

1. Revert only the website-related apex and optional `www` records.
2. Do not modify the unrelated service subdomains while troubleshooting.
3. Re-check the GitHub Pages custom-domain state before making further DNS edits.
