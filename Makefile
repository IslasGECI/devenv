all: install tests

SHELL := /bin/bash

.PHONY: \
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
	apt install --simulate build-essential | grep "build-essential is already the newest version"
	apt install --simulate libcurl4-openssl-dev | grep "libcurl4-openssl-dev is already the newest version"
	apt install --simulate libssl-dev | grep "libssl-dev is already the newest version"
	apt install --simulate libxml2-dev | grep "libxml2-dev is already the newest version"
	npm --version | grep "^8"
	pyright --version | grep "pyright 1"
	python --version | grep "Python 3.10"
	R --version | grep "Unsuffered Consequences"
	Rscript -e "packageVersion('languageserver')" | grep "0."

test_os_packages:
	$$HOME/.local/lib/shellspec/bin/shellspec --version | grep "^0"
	$$HOME/go/bin/lazygit --version | grep "unversioned"
	$$HOME/squashfs-root/usr/bin/nvim --version | grep "NVIM v0.7"
	ctags --version | grep "Universal Ctags 5"
	curl --version | grep "curl 7"
	exa --version | grep "v0"
	fdfind --version | grep "fd 8"
	git --version | grep "version 2"
	go version | grep "version go1"
	neofetch --version | grep "Neofetch 7"
	pip --version | grep "pip 22"
	rg --version | grep "ripgrep 13"
	shellcheck --version | grep "version: 0"
	tmux -V | grep "tmux 3"
	wget --version | grep "Wget 1"

test_os_version:
	cat /etc/os-release | grep "Jammy Jellyfish"
	cat /etc/os-release | grep "22.04 LTS"

tests: \
		test_external_python_modules \
		test_language_server_protocol \
		test_os_packages \
		test_os_version \
