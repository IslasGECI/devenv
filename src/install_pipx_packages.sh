#!/usr/bin/env bash
#
# Install packages with pipx

# unofficial strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

# Install packages with pipx
PIPX_BIN_DIR=/usr/local/bin && \
pipx install \
    rich-cli
pipx ensurepath
