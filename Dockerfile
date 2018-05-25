FROM irreverentpixelfeats/dev-base:ubuntu_xenial-20180518002608-1e19e96
LABEL maintainer "domdere@irreverentpixelfeats.com"

RUN apt-get update && apt-get install -y \
  opam

RUN opam init \
  && opam switch 4.05.0 \
  && cd /tmp \
  && git clone https://github.com/Barry-Jay/bondi.git \
  && cd bondi \
  && git checkout "53494d1" \
  && cd .. \
  && opam pin add bondi bondi -y \
  && cp ~/.opam/4.05.0/bin/bondi /usr/local/bin \
  && rm -rfv bondi

RUN mkdir -p /var/versions

COPY data/version /var/versions/bondi-dev
