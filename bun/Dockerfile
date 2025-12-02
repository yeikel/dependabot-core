# syntax=docker.io/docker/dockerfile:1.20
FROM oven/bun:1.3-debian@sha256:3da1c52799fc527af4c5969876734cbaddbf3e49479c601cfebdb0d7cbcc61b4 AS bun

FROM ghcr.io/dependabot/dependabot-updater-core

USER dependabot

# Configure Bun to use our custom CA bundle
ENV NODE_EXTRA_CA_CERTS=/etc/ssl/certs/ca-certificates.crt

COPY --from=bun /usr/local/bin/bun /usr/local/bin/bun

COPY --chown=dependabot:dependabot --parents bun common $DEPENDABOT_HOME/
COPY --chown=dependabot:dependabot updater $DEPENDABOT_HOME/dependabot-updater
