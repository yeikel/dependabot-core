# syntax=docker.io/docker/dockerfile:1.20
# This cannot be inlined below (e.g., COPY --from=...) because Dependabot does not support that syntax yet
FROM ghcr.io/astral-sh/uv:0.9.11 AS uv

FROM ghcr.io/dependabot/dependabot-updater-pip

# Install uv by copying from the official image
COPY --from=uv /uv /uvx /usr/local/bin/

COPY --chown=dependabot:dependabot --parents uv $DEPENDABOT_HOME/
