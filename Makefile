SOURCE = $(shell find src/*)
DOCS = $(patsubst src/%.md, docs/%.md, $(SOURCE))

.PHONY: all
all: $(DOCS)

docs/%.md: src/%.md
	mkdir -p "$(@D)"
	cp "$<" "$@"
