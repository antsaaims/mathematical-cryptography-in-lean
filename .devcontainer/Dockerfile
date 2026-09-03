FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Set default shell to bash
SHELL ["/bin/bash", "-c"]

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl git python3 && \
    apt-get clean
