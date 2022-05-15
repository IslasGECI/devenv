#!/usr/bin/env --split-string="bash -euo pipefail"
#
# Install latest Neovim from GitHub
cd "$HOME"
wget --directory-prefix="$HOME" https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x "$HOME"/nvim.appimage
"$HOME"/nvim.appimage --appimage-extract

# Install packer.nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/packer/start/packer.nvim
