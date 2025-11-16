# From https://github.com/sigstore/cosign/releases
FROM ghcr.io/sigstore/cosign/cosign:v3.0.1 AS cosign
# From https://github.com/regclient/regclient/releases
FROM ghcr.io/regclient/regctl:v0.9.2 AS regctl
# From https://github.com/helm/helm/releases
FROM alpine/helm:3.17.2 AS helm
# From https://github.com/oras-project/oras/releases
FROM ghcr.io/oras-project/oras:v1.2.2 AS oras

FROM ghcr.io/dependabot/dependabot-updater-core

ENV PATH=/opt/bin:$PATH

COPY --from=regctl /regctl /opt/bin/regctl
COPY --from=cosign /ko-app/cosign /opt/bin/cosign
COPY --from=helm /usr/bin/helm /opt/bin/helm
COPY --from=oras /bin/oras /opt/bin/oras

# Verify regctl installation using cosign
RUN REGCTL_VERSION=$(regctl version --format '{{.VCSTag}}') && \
    cosign verify \
      --certificate-oidc-issuer https://token.actions.githubusercontent.com \
      --certificate-identity-regexp https://github.com/regclient/regclient/.github/workflows/ \
      ghcr.io/regclient/regctl:${REGCTL_VERSION} && \
    # Remove cosign as it is not needed in the final image
    rm /opt/bin/cosign

USER dependabot

COPY --chown=dependabot:dependabot helm $DEPENDABOT_HOME/helm
COPY --chown=dependabot:dependabot common $DEPENDABOT_HOME/common
COPY --chown=dependabot:dependabot updater $DEPENDABOT_HOME/dependabot-updater
COPY --chown=dependabot:dependabot docker $DEPENDABOT_HOME/docker
