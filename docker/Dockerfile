FROM ghcr.io/regclient/regctl:v0.9.1 AS regctl

FROM ghcr.io/dependabot/dependabot-updater-core
ARG TARGETARCH

ENV PATH=/opt/bin:$PATH

COPY --from=regctl /regctl /opt/bin/regctl
RUN chmod o+rx /opt/bin/regctl

USER dependabot

COPY --chown=dependabot:dependabot docker $DEPENDABOT_HOME/docker
COPY --chown=dependabot:dependabot common $DEPENDABOT_HOME/common
COPY --chown=dependabot:dependabot updater $DEPENDABOT_HOME/dependabot-updater
