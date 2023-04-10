FROM ghcr.io/dependabot/dependabot-updater-core
ARG TARGETARCH

# Install regctl
ARG REGCTL_VERSION=0.4.7

ENV PATH=/opt/bin:$PATH

RUN curl -L https://github.com/regclient/regclient/releases/download/v$REGCTL_VERSION/regctl-linux-${TARGETARCH} > regctl \
&& curl -L https://github.com/regclient/regclient/releases/download/v$REGCTL_VERSION/metadata.tgz > metadata.tgz \
&& tar -xzf metadata.tgz regctl-linux-${TARGETARCH}.pem regctl-linux-${TARGETARCH}.sig \
&& cosign verify-blob \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  --certificate-identity-regexp https://github.com/regclient/regclient/.github/workflows/ \
  --certificate regctl-linux-${TARGETARCH}.pem \
  --signature regctl-linux-${TARGETARCH}.sig \
 regctl \
&& rm metadata.tgz regctl-linux-${TARGETARCH}.pem regctl-linux-${TARGETARCH}.sig \
&& mv regctl-${TARGETARCH} /opt/bin/regctl && chmod o+rx /opt/bin/regctl

USER dependabot

COPY --chown=dependabot:dependabot docker /home/dependabot/docker
