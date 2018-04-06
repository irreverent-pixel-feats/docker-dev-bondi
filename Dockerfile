FROM irreverentpixelfeats/dev-base:ubuntu_xenial-20180323222525-c66625b
MAINTAINER Dom De Re <domdere@irreverentpixelfeats.com>

ARG GHC_VERSION
ARG CABAL_VER

RUN apt-get update -y \
  && apt-add-repository -y "ppa:hvr/ghc" \
  && apt-get update -y \
  && apt-get install -y ghc-${GHC_VERSION} cabal-install-${CABAL_VER} \
  && ln -sf /opt/ghc/bin/* /usr/local/bin \
  && ln -sf /opt/cabal/bin/* /usr/local/bin \
  && cabal update

RUN mkdir -p ~/bin/packages/happy \
  && cd ~/bin/packages/happy \
  && cabal sandbox init \
  && cabal install happy \
  && ln -sf ~/bin/packages/happy/.cabal-sandbox/bin/happy /usr/local/bin/happy

RUN mkdir -p ~/bin/packages/pointful \
  && cd ~/bin/packages/pointful \
  && cabal sandbox init \
  && cabal install -j pointful \
  && ln -sf ~/bin/packages/pointful/.cabal-sandbox/bin/pointful /usr/local/bin/pointful

RUN mkdir -p ~/bin/packages/pointfree \
  && cd ~/bin/packages/pointfree \
  && cabal sandbox init \
  && cabal install -j pointfree \
  && ln -sf ~/bin/packages/pointfree/.cabal-sandbox/bin/pointfree /usr/local/bin/pointfree

RUN mkdir -p ~/bin/packages/hoogle \
  && cd ~/bin/packages/hoogle \
  && cabal sandbox init \
  && cabal install -j hoogle \
  && ln -sf ~/bin/packages/hoogle/.cabal-sandbox/bin/hoogle /usr/local/bin/hoogle

RUN mkdir -p ~/bin/packages/hasktags \
  && cd ~/bin/packages/hasktags \
  && cabal sandbox init \
  && cabal install -j hasktags \
  && ln -sf ~/bin/packages/hoogle/.cabal-sandbox/bin/hasktags /usr/local/bin/hasktags

RUN mkdir -p ~/bin/packages/ghc-mod \
  && cd ~/bin/packages/ghc-mod \
  && cabal sandbox init \
  && cabal install -j ghc-mod \
  && ln -sf ~/bin/packages/ghc-mod/.cabal-sandbox/bin/ghc-mod /usr/local/bin/ghc-mod \
  && ln -sf ~/bin/packages/ghc-mod/.cabal-sandbox/bin/ghci-mod /usr/local/bin/ghci-mod

ADD data tmp

RUN mkdir -p /var/versions \
  && cp /tmp/version /var/versions/haskell-dev
