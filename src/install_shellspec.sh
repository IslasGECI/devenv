#!/usr/bin/env bash
#
# Install latest ShellSpec

# unofficial strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Install latest ShellSpec

curl \
    --fail \
    --location https://git.io/shellspec \
    --show-error \
    --silent \
    | sh -s -- --yes
shellspec --init
