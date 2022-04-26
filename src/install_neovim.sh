#!/usr/bin/env bash
#
# Install latest Neovim from GitHub

# unofficial strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Install latest Neovim from GitHub
cd "$HOME"
wget --directory-prefix="$HOME" https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x "$HOME"/nvim.appimage
"$HOME"/nvim.appimage --appimage-extract
