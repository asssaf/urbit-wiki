install: check-env
	cp -a src/* $(DESTDIR)/home/

check-env:
ifndef DESTDIR
	$(error DESTDIR is undefined)
endif
ifeq ($(wildcard $(DESTDIR)),)
	$(error "$(DESTDIR) doesn't exist. Did you mount home?")
endif

.PHONY: install check-env
