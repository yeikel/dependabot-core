# syntax=docker.io/docker/dockerfile:1.20
FROM ghcr.io/dependabot/dependabot-updater-core

# Check for updates at https://github.com/oven-sh/bun/releases
FROM oven/bun:1.3.3 AS bun

USER dependabot

# Configure Bun to use our custom CA bundle
# Even though Bun doesn't use Node, it respects this environment variable: https://bun.com/blog/bun-v1.1.22#node-extra-ca-certs
ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt

COPY --chown=dependabot:dependabot --from=bun /usr/local/bin/bun /usr/bin/bun
COPY --chown=dependabot:dependabot --parents bun common $DEPENDABOT_HOME/
COPY --chown=dependabot:dependabot updater $DEPENDABOT_HOME/dependabot-updater
