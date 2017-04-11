
.PHONY: all
all:
	@rsync -av --delete src/ docs/
