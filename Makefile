PATH_THIS:=$(realpath $(dir $(lastword ${MAKEFILE_LIST})))
DIR:=$(PATH_THIS)

include base.env
VARS:=$(shell sed -ne 's/ *\#.*$$//; /./ s/=.*$$// p' base.env )
$(foreach v,$(VARS),$(eval $(shell echo export $(v)="$($(v))")))

include .env
VARS:=$(shell sed -ne 's/ *\#.*$$//; /./ s/=.*$$// p' .env )
$(foreach v,$(VARS),$(eval $(shell echo export $(v)="$($(v))")))

help:
	@echo "    server"
	@echo "        Run server"
	@echo "    migrate"
	@echo "        Run migrations"


.PHONY: server
server:
	@cd $(DIR) \
	&& echo $$DB_URL \
	&& gin -i run server

.PHONY: migrate
migrate:
	@cd $(DIR) \
	&& gorm-goose up
