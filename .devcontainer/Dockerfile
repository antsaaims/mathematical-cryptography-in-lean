FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

SHELL ["/bin/bash", "-c"]

# Install system dependencies
RUN apt-get update && \
    apt-get install -y curl git python3 sudo xz-utils && \
    apt-get clean

# Install Node.js 22 LTS via binary tarball (avoids NodeSource repo issues
# and ensures Node 22 is at /usr/local/bin, taking precedence over any
# Node 18 that Codespaces override might inject)
RUN ARCH=$(dpkg --print-architecture) && \
    if [ "$ARCH" = "amd64" ]; then NODE_ARCH=x64; \
    elif [ "$ARCH" = "arm64" ]; then NODE_ARCH=arm64; \
    else NODE_ARCH=x64; fi && \
    curl -fsSL "https://nodejs.org/dist/v22.11.0/node-v22.11.0-linux-${NODE_ARCH}.tar.xz" \
      -o /tmp/node.tar.xz && \
    tar -xf /tmp/node.tar.xz -C /usr/local --strip-components=1 && \
    rm /tmp/node.tar.xz && \
    node --version && npm --version

# Ensure vscode user exists with correct home directory
RUN mkdir -p /home/vscode && \
    chown -R vscode:vscode /home/vscode

ENV HOME=/home/vscode
USER vscode
