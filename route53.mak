#
# Copyright (C) 2016 Andrew Ayer
#
# See COPYING file for license information.
#

ZONES ?= $(wildcard [a-z0-9]*)
PROFILE ?= default

all: $(addprefix .route53/,$(ZONES))

.route53/%: %
	cli53 import --profile $(PROFILE) --file $< --replace --editauth --wait $(notdir $@)
	mkdir -p .route53
	touch $@

%:
	cli53 export --profile $(PROFILE) $@ > /dev/null || cli53 create --profile $(PROFILE) $@
	cli53 export --profile $(PROFILE) $@ > $@

.PHONY: all
