VERSION := $(shell cat VERSION)

.PHONY: tag
tag:
	git tag -d v0
	git tag -a $(VERSION) -m "Release $(VERSION)"
	git push --tags

.PHONY: release
release: tag
	git push origin main
