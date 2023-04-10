FROM ghcr.io/dependabot/dependabot-updater-core
ARG TARGETARCH

# Install regctl
ARG REGCTL_VERSION=0.4.7

ENV PATH=/opt/bin:$PATH

curl -L https://github.com/regclient/regclient/releases/$REGCTL_VERSION/download/regctl-linux-${TARGETARCH} > regctl \
&& chmod 755 regctl
&& curl -L https://github.com/regclient/regclient/releases/$REGCTL_VERSION/download/metadata.tgz >metadata.tgz
&& tar -xzf metadata.tgz regctl-linux-${TARGETARCH}.pem regctl-linux-${TARGETARCH}.sig
&& cosign verify-blob \
  --certificate-oidc-issuer https://token.actions.githubusercontent.com \
  --certificate-identity-regexp https://github.com/regclient/regclient/.github/workflows/ \
  --certificate regctl-linux-${TARGETARCH}.pem \
  --signature regctl-linux-${TARGETARCH}.sig \
 regctl
&& rm metadata.tgz regctl-linux-${TARGETARCH}.pem regctl-linux-${TARGETARCH}.sig


RUN cd /tmp \
  && curl -sSf -o regctl-${TARGETARCH} -L https://github.com/regclient/regclient/releases/download/v${REGCTL_VERSION}/regctl-linux-${TARGETARCH} \
  && printf "$REGCTL_AMD64_CHECKSUM regctl-amd64\n$REGCTL_ARM64_CHECKSUM regctl-arm64\n" | sha256sum -c --ignore-missing - \
  && mkdir /opt/bin \
  && mv regctl-${TARGETARCH} /opt/bin/regctl \
  && chmod o+rx /opt/bin/regctl

USER dependabot

COPY --chown=dependabot:dependabot docker /home/dependabot/docker
