#!/usr/bin/env bash
#
# Install latest ShellSpec

# unofficial strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

# Install latest ShellSpec
curl \
    --fail \
    --location https://git.io/shellspec \
    --show-error \
    --silent \
    | sh -s -- --yes
sed --in-place '1s/^/export PATH="$HOME\/.local\/lib\/shellspec:$PATH"\n/' ~/.profile
"$HOME/.local/lib/shellspec/shellspec" --init

