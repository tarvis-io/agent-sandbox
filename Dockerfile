# Shared coding environment. Published for ARM64 and AMD64.
FROM docker.io/library/node:24-alpine@sha256:ebfe2f90462722a7a4de65e91990e97fe0d401c70e0e762c5b53302f905ec1c1
LABEL io.tarvis.keep=true \
    org.opencontainers.image.source="https://github.com/tarvis-io/agent-sandbox" \
    org.opencontainers.image.description="Node and Python runtime for Tarvis coding sandboxes"
RUN apk add --no-cache python3 py3-pip bash git curl ca-certificates \
    && ln -sf /usr/bin/python3 /usr/local/bin/python \
    && python -m venv /tmp/python-check \
    && /tmp/python-check/bin/python -m pip --version \
    && rm -rf /tmp/python-check
WORKDIR /workspace
