# \ var
MODULE  = $(notdir $(CURDIR))
OS      = $(shell uname -s)
MACHINE = $(shell uname -m)
NOW     = $(shell date +%d%m%y)
REL     = $(shell git rev-parse --short=4 HEAD)
BRANCH  = $(shell git rev-parse --abbrev-ref HEAD)
CORES   = $(shell grep processor /proc/cpuinfo| wc -l)
# / var

# \ dir
CWD     = $(CURDIR)
BIN     = $(CWD)/bin
TMP     = $(CWD)/tmp
# / dir

# \ tool
CURL    = curl -L -o
REBAR   = $(BIN)/rebar3
ERLC    = erlc
ERL     = erl
# / tool

.PHONY: all
all:
	$(REBAR) compile

# \ install
.PHONY: install update
install: $(OS)_install
	$(MAKE) rebar
	$(MAKE) update
update: $(OS)_update
	$(REBAR) deps

.PHONY: Linux_install Linux_update
Linux_install Linux_update:
	sudo apt update
	sudo apt install -u `cat apt.txt apt.dev`
# \ erlang
.PHONY: rebar
rebar: $(REBAR)
$(REBAR):
	$(CURL) $@ https://s3.amazonaws.com/rebar3/rebar3 && chmod +x $@
	$(REBAR) local install
# / erlang
# / install

# \ merge
.PHONY: zip
zip:
	git archive \
		--format zip \
		--output $(TMP)/$(MODULE)_$(BRANCH)_$(NOW)_$(REL).src.zip \
	HEAD
# / merge

