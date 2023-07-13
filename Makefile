all: tests

SHELL := /bin/bash

.PHONY: \
	all \
	test_docker_installed_versions \
	test_external_python_modules \
	test_language_server_protocol \
	test_os_packages \
	test_os_version \
	tests

test_docker_installed_versions:
	Rscript -e "packageVersion('languageserver')" | egrep "0\.[0-9]+\.[0-9]+"
	apt-cache policy fd-find | grep "Installed: 8"
	apt-cache policy ripgrep | grep "Installed: 13"
	apt-cache policy universal-ctags | grep "Installed: 5"
	apt-cache policy wget | grep "Installed: 1"
	node --version | grep "v18"
	npm --version | grep "^9"
	nvim --version | grep "NVIM v0.9"
	pip freeze | grep rope==1
	pyright --version | grep "pyright 1"

test_external_python_modules:
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command pip freeze | grep black-23
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command pip freeze | grep flake8-6
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command pip freeze | grep ipython-8
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command pip freeze | grep pylint-2
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command pip freeze | grep pytest-7
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command pip freeze | grep rope-1

test_language_server_protocol:
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command node --version | grep "v20"
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command npm --version | grep "^9"
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command pyright --version | grep "pyright 1"
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command python --version | grep "Python 3.10"
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command R --version | grep "version 4"
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command Rscript -e "packageVersion('languageserver')" | egrep "0\.[0-9]+\.[0-9]+"
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command unzip -v | grep "UnZip 6"

test_os_packages:
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command ctags --version | grep "Ctags 6"
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command fd --version | grep "fd 8"
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command mutmut --version | grep "version 2"
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command nvim --version | grep "NVIM v0.9"
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command pip --version | grep "pip 23"
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command rg --version | grep "ripgrep 13"
	. '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' && nix develop --command shellcheck --version | grep "version: 0"

test_os_version:
	cat /etc/os-release | grep "22.04"
	cat /etc/os-release | grep "Jammy Jellyfish"
	cat /etc/os-release | grep "LTS"

tests: \
		test_docker_installed_versions \
		test_external_python_modules \
		test_language_server_protocol \
		test_os_packages \
		test_os_version
