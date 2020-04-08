.PHONY: test
test: $(wildcard tests/*.bats)
	bats $^
