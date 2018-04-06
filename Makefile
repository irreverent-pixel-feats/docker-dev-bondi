REPO = irreverentpixelfeats/dev-haskell
BASE_TAG = ubuntu_xenial

.PHONY: version publish deps build image all

version:
	bin/git-version ./latest-version
	diff -q latest-version data/version || cp -v latest-version data/version
	rm latest-version

deps: version

build: deps Dockerfile
	bin/build-images "${REPO}" "${BASE_TAG}" "$(shell cat "data/version")"

publish: build
	bin/ci.publish "${REPO}" "${BASE_TAG}" "$(shell cat "data/version")"

all: build image
