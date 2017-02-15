#
# Copyright (C) 2016 Andrew Ayer
#
# See COPYING file for license information.
#

ZONES ?= $(subst db.,,$(wildcard db.*))
PROFILE ?= default

all: $(addprefix .route53/,$(ZONES))

.route53/%: db.%
	cli53 import --profile $(PROFILE) --file $< --replace --wait $(notdir $@)
	mkdir -p .route53
	touch $@

db.%:
	cli53 export --profile $(PROFILE) $(subst db.,,$@) > /dev/null || cli53 create --profile $(PROFILE) $(subst db.,,$@)
	cli53 export --profile $(PROFILE) $(subst db.,,$@) > $@

.PHONY: all
