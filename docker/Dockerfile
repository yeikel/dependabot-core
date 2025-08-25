ARG TARGETARCH
# From https://github.com/regclient/regclient/releases
FROM ghcr.io/regclient/regctl:v0.9.0 AS regctl

FROM ghcr.io/dependabot/dependabot-updater-core

ENV PATH=/opt/bin:$PATH
COPY --from=regctl /regctl /opt/bin/regctl
RUN chmod o+rx /opt/bin/regctl

# Verify regclient binary. See https://regclient.org/install/#verifying-signatures
RUN cosign verify \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  --certificate-identity-regexp https://github.com/regclient/regclient/.github/workflows/ \
  ghcr.io/regclient/regctl:v0.9.0

USER dependabot

COPY --chown=dependabot:dependabot docker $DEPENDABOT_HOME/docker
COPY --chown=dependabot:dependabot common $DEPENDABOT_HOME/common
COPY --chown=dependabot:dependabot updater $DEPENDABOT_HOME/dependabot-updater
