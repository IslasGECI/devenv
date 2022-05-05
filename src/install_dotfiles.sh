#!/usr/bin/env bash
#
# Install dotfiles from GitHub

# unofficial strict mode: http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail

# Install dotfiles from GitHub
git clone --bare git@github.com:devarops/dotfiles.git ${HOME}/dotfiles.git
git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME} checkout
git --git-dir=${HOME}/dotfiles.git --work-tree=${HOME} config --local status.showUntrackedFiles no
