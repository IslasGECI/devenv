#!/usr/bin/env bash
#
# Install packages with pipx

# unofficial strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

# Install packages with pipx
pipx install \
    rich-cli
pipx ensurepath
