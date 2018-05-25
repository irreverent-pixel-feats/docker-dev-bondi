REPO = irreverentpixelfeats/dev-bondi
BASE_TAG = ubuntu_xenial

.PHONY: version deps build image all

version:
	bin/git-version ./latest-version
	diff -q latest-version data/version || cp -v latest-version data/version
	rm latest-version

deps: version

build: deps Dockerfile
	bin/build-image "${REPO}:${BASE_TAG}" "${BONDIVER}" "$(shell cat "data/version")"

all: build image
