#
# Copyright (C) 2024 Teltonika-Networks
#

# colors
_R:=\\033[31m
_N:=\\033[m

itest:
ifeq ($(wildcard bin/targets/x86/**/tltFws/X86*_combined-efi.img.gz),)
	$(error $(shell printf "$(_R)Integration tests can only be run with x86_64 FW. Select x86_64 and make the FW first$(_N)"))
endif # TARGET_X86_64
ifeq ($(TEST),)
	$(error $(shell printf "$(_R)No file to test. Specify TEST=<test file>. To run tests interactively without restarting the emulator, specify TEST=shell$(_N)"))
endif # TEST
	@IMG_NAME="$(GITLAB_REGISTRY_HOST)/teltonika/rutx_open/tbot" \
		IMG_TAG="$$(grep -E '^\s*\.image_tbot:.*:[\[ $$A-Za-z0-9.]+$$' .gitlab/ci/templates/images.yml | rev | cut -d':' -f1 | rev | tr -d '\n')" \
		./scripts/docker-bootstrap /run_tests.sh $(if $(findstring $(TEST),shell),,"$(TEST)")
