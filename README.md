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

In GitHub repository settings:

1. Open `Settings -> Pages`.
2. Set `Source` to `GitHub Actions`.
3. Merge or push the site changes to `main`.

## Cloudflare Follow-Up

After the Pages site is live:

1. Add the custom domain in GitHub Pages settings.
2. Create the matching DNS record in Cloudflare.
3. Enable Cloudflare SSL and confirm the hostname resolves to the Pages deployment.
