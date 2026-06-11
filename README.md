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

The workflow prepares a clean `dist/` artifact before upload. It copies the homepage assets, writes `.nojekyll`, and writes `CNAME` automatically when the repository variable `PRAETOR_PAGES_CNAME` is set.

In GitHub repository settings:

1. Open `Settings -> Pages`.
2. Set `Source` to `GitHub Actions`.
3. Merge or push the site changes to `main`.
4. If you want a custom domain, add repository variable `PRAETOR_PAGES_CNAME` with the exact hostname, for example `home.example.com`.

If `gh` is not authenticated yet, run:

```bash
gh auth login -h github.com
```

## Cloudflare Follow-Up

After the Pages site is live and you know the final hostname:

1. Confirm the same hostname appears in GitHub Pages as the custom domain.
2. Create the matching `CNAME` record in Cloudflare pointing at `<your-github-pages-host>`.
3. Keep Cloudflare SSL/TLS enabled and verify the hostname serves the Pages site successfully.
4. If you want the apex domain as well, add the required redirect or alias setup in Cloudflare after the primary hostname works.
