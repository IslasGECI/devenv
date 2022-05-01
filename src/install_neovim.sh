#!/usr/bin/env bash
#
# Install latest Neovim from GitHub

# unofficial strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

# Install latest Neovim from GitHub
cd "$HOME"
wget --directory-prefix="$HOME" https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod u+x "$HOME"/nvim.appimage
"$HOME"/nvim.appimage --appimage-extract

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"$HOME/squashfs-root/usr/bin/nvim" -es -u "$HOME/.config/nvim/init.vim" -i NONE -c "PlugInstall" -c "qa" -V
