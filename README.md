# Praetor Home Systems Homepage

Static homepage for Praetor Home Systems LLC, designed for simple GitHub Pages deployment.

## Local Preview

Build and run with Docker:

```bash
docker build -t praetor-homepage .
docker run --rm -p 8080:80 praetor-homepage
```

Then open `http://localhost:8080`.

If you prefer Compose:

```bash
docker compose up --build
```

## Deployment

This repo includes a GitHub Actions workflow that deploys the static site to GitHub Pages on pushes to `main`.

The workflow prepares a clean `dist/` artifact before upload. It copies the homepage assets, writes `.nojekyll`, and writes `CNAME` automatically for the production hostname `praetorhomesystems.com`.

In GitHub repository settings:

1. Open `Settings -> Pages`.
2. Set `Source` to `GitHub Actions`.
3. Merge or push the site changes to `main`.
4. Set the custom domain to `praetorhomesystems.com`.

If you ever need to test a different hostname temporarily, the artifact script still accepts `PRAETOR_PAGES_CNAME` as an override.

If `gh` is not authenticated yet, run:

```bash
gh auth login -h github.com
```

## Cloudflare Follow-Up

After the Pages site is live:

1. Confirm `praetorhomesystems.com` appears in GitHub Pages as the custom domain.
2. In Cloudflare, point the apex hostname `praetorhomesystems.com` at the GitHub Pages target using the GitHub-recommended DNS setup for apex domains.
3. Optionally add `www.praetorhomesystems.com` as a `CNAME` to the same GitHub Pages target and redirect it to the apex host if you want a single canonical public URL.
4. Leave unrelated service subdomains such as `legio-13.praetorhomesystems.com` unchanged. They can keep their own records and do not conflict with the website cutover.
5. Keep Cloudflare SSL/TLS enabled and verify the hostname serves the Pages site successfully after DNS propagation.
