all: install tests

SHELL := /bin/bash

.PHONY: \
	all \
	install \
	test_external_python_modules \
	test_language_server_protocol \
	test_os_packages \
	test_os_version \
	tests

check:
	shellcheck src/*

install:
	src/install_lazygit.sh
	src/install_neovim.sh
	src/install_npm_packages.sh
	src/install_pipx_packages.sh
	src/install_shellspec.sh

test_external_python_modules:
	pip freeze | grep black==22
	pip freeze | grep dunk==0
	pip freeze | grep flake8==4
	pip freeze | grep ipython==8
	pip freeze | grep mutmut==2
	pip freeze | grep powerline-shell==0
	pip freeze | grep pylint==2
	pip freeze | grep pytest==7
	pip freeze | grep rope==1

test_language_server_protocol:
	Rscript -e "packageVersion('languageserver')" | egrep "0\.[0-9]+\.[0-9]+"
	apt-cache policy build-essential | grep "Installed: 12"
	apt-cache policy libcurl4-openssl-dev | grep "Installed: 7"
	apt-cache policy libssl-dev | grep "Installed: 3"
	apt-cache policy libxml2-dev | grep "Installed: 2"
	apt-cache policy npm | grep "Installed: 8"
	apt-cache policy python3 | grep "Installed: 3.10"
	apt-cache policy r-base | grep "Installed: 4"
	pyright --version | grep "pyright 1"

test_os_packages:
	$$HOME/.local/lib/shellspec/bin/shellspec --version | grep "^0"
	$$HOME/go/bin/lazygit --version | grep "unversioned"
	$$HOME/squashfs-root/usr/bin/nvim --version | grep "NVIM v0.7"
	apt-cache policy curl | grep "Installed: 7"
	apt-cache policy exa | grep "Installed: 0"
	apt-cache policy fd-find | grep "Installed: 8"
	apt-cache policy git | grep "Installed: 1:2"
	apt-cache policy golang-go | grep "Installed: 2:1"
	apt-cache policy neofetch | grep "Installed: 7"
	apt-cache policy pipx | grep "Installed: 1"
	apt-cache policy python3-pip | grep "Installed: 22"
	apt-cache policy ripgrep | grep "Installed: 13"
	apt-cache policy shellcheck | grep "Installed: 0"
	apt-cache policy tmux | grep "Installed: 3"
	apt-cache policy universal-ctags | grep "Installed: 5"
	apt-cache policy wget | grep "Installed: 1"
	rich --version | grep "^1"

test_os_version:
	cat /etc/os-release | grep "22.04"
	cat /etc/os-release | grep "Jammy Jellyfish"
	cat /etc/os-release | grep "LTS"

tests: \
		test_external_python_modules \
		test_language_server_protocol \
		test_os_packages \
		test_os_version \
