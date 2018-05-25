FROM irreverentpixelfeats/dev-base:ubuntu_xenial-20180518002608-1e19e96
MAINTAINER Dom De Re <"domdere@irreverentpixelfeats.com">

ARG BONDI_SHA

ENV OCAML_VER="4.05.0"

RUN apt-get update && apt-get install -y \
  opam

RUN opam init \
  && opam switch "${OCAML_VER}" \
  && cd /tmp \
  && git clone https://github.com/Barry-Jay/bondi.git \
  && cd bondi \
  && git checkout "53494d1" \
  && cd .. \
  && opam pin add bondi bondi -y \
  && cp ~/.opam/${OCAML_VER}/bin/bondi /usr/local/bin \
  && rm -rfv bondi

RUN mkdir -p /var/versions

COPY data/version /var/versions/bondi-dev
