all: process

SRCS := $(shell ls logs/*.dump)
DESTS := $(patsubst logs/%.dump,processed-logs/%.dump,$(SRCS))

process: $(DESTS)

$(DESTS): processed-logs/%.dump: logs/%.dump
	perl -E 'my ($$s, $$d) = @ARGV; use IO::All qw(io); io->file($$d)->print(io->file($$s)->all =~ s/^Reached Board No\.[^\n]*\n//gmrs);' "$<" "$@"


%.show:
	@echo "$* = $($*)"
