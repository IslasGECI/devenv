tests: \
		test_external_python_modules \
		test_os_version \
		test_python_version \
		test_r_version \

SHELL := /bin/bash

.PHONY: \
		test_external_python_modules \
		test_os_version \
		test_python_version \
		test_r_version \
		tests

test_external_python_modules:
	pip freeze | grep black==22
	pip freeze | grep flake8==4
	pip freeze | grep ipython==8
	pip freeze | grep mutmut==2
	pip freeze | grep powerline-shell==0
	pip freeze | grep pylint==2
	pip freeze | grep pytest==7
	pip freeze | grep rope==1

test_os_version:
	cat /etc/os-release | grep "22.04"

test_python_version:
	python --version | grep "Python 3.10"

test_r_version:
	R --version | grep 4.1
