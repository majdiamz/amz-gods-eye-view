# Deploying AMZ God's Eye View on Coolify

This repository is an AMZ-managed fork of the upstream God's Eye View project and includes a Docker configuration for repeatable Coolify deployments.

## Recommended Coolify setup

1. In Coolify create or select a project and environment.
2. Add a new **Application** from GitHub.
3. Select `majdiamz/amz-gods-eye-view` and branch `main`.
4. Select **Dockerfile** as the build pack.
5. Dockerfile location: `/Dockerfile`.
6. Exposed/internal port: `4173`.
7. Add a domain in Coolify and enable HTTPS.
8. Add environment variables in Coolify. Never commit real API keys.
9. Deploy.

## Minimal environment variables

```env
HOST=0.0.0.0
PORT=4173
OPENSKY_AUTH_MODE=anon
```

The application can start without paid provider keys. Some layers/features require optional provider credentials.

## Optional provider variables

```env
CESIUM_ION_TOKEN=
GOOGLE_MAPS_API_KEY=
GOOGLE_MAPS_SERVER_API_KEY=
OPENAI_API_KEY=
AISSTREAM_API_KEY=
FIRMS_MAP_KEY=
TOMTOM_API_KEY=
OPENSKY_CLIENT_ID=
OPENSKY_CLIENT_SECRET=
LL2_API_TOKEN=
```

Read `.env.example` for the complete list and comments.

## Important security note

`GOOGLE_MAPS_API_KEY` and `CESIUM_ION_TOKEN` are browser-facing by design. Restrict them at their providers. Other private provider keys should remain server-side. If the instance is public, configure provider quotas/rate limits and consider an authentication layer before adding metered credentials.

## Automatic deployments

After the first successful deployment, enable Coolify's **Deploy on Push / GitHub webhook** for the application. The intended workflow is:

```text
edit code -> push to main -> GitHub -> Coolify webhook -> build -> deploy
```

This makes this repository the deployment source of truth.

## Updating from upstream

This repository originated from `bilawalsidhu/gods-eye-view`. Do not blindly synchronize upstream into production. Review upstream changes first, merge them into a dedicated branch, test, and then merge into `main`.

Your fork is not automatically overwritten when upstream changes.

## Local Docker test

```bash
docker build -t amz-gods-eye-view .
docker run --rm -p 4173:4173 \
  -e OPENSKY_AUTH_MODE=anon \
  amz-gods-eye-view
```

Then open `http://localhost:4173`.

## Local Node development

The project currently requires Node 24.14+ (or a compatible Node 26 release per package.json).

```bash
npm ci
npm run dev -- --host localhost --port 4173
```

See the upstream README, SECURITY.md and DATA_SOURCES.md for provider-specific configuration, security considerations and data-source terms.
