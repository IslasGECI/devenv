#!/usr/bin/env bash
#
# Install latest lazygit from GitHub

# unofficial strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Install latest lazygit from GitHub
go install github.com/jesseduffield/lazygit@latest
