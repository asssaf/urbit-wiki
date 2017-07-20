DIRS = sur app mar web

install: check-env
	$(foreach dir,$(DIRS), cp -a $(dir)/* $(DESTDIR)/home/$(dir);)

check-env:
ifndef DESTDIR
	$(error DESTDIR is undefined)
endif
ifeq ($(wildcard $(DESTDIR)),)
	$(error "$(DESTDIR) doesn't exist. Did you mount home?")
endif

.PHONY: install check-env
