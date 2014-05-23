all: process

SRCS := $(shell ls logs/*.dump)
DESTS := $(patsubst logs/%.dump,processed-logs/%.dump,$(SRCS))

TOTAL = fc-solve-l-amateur-star-100M+1-to-1000M.total.dump

process: $(TOTAL) $(DESTS)

$(DESTS): processed-logs/%.dump: logs/%.dump
	perl -E 'my ($$s, $$d) = @ARGV; use IO::All qw(io); io->file($$d)->print(io->file($$s)->all =~ s/^Reached Board No\.[^\n]*\n//gmrs);' "$<" "$@"

$(TOTAL): $(DESTS)
	cat $(DESTS) > $(TOTAL)

%.show:
	@echo "$* = $($*)"
