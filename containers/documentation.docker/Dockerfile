FROM debian:stretch
MAINTAINER ArangoDB Hackers <hacker@arangodb.com>

#set proper shell
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# install base dependencies
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        apt-transport-https \
        build-essential \
        ca-certificates \
        curl \
        git \
        libssl-dev \
        wget \
        rsync \
        tree \
        && apt-get clean

## install packages for python
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        python \
        python-setuptools \
        python-pip \
        python-argparse \
        && apt-get clean

## install packages for doc
RUN apt-get update && apt-get install -y -q --no-install-recommends \
        git \
        calibre \
        calibre-bin \
        tar \
        ditaa \
        && apt-get clean

## get nvm
ENV NVM_DIR /usr/local/nvm
ENV NODE_VERSION 8.11.3
ENV NODE_PATH $NVM_DIR/versions/node/v$NODE_VERSION/lib/node_modules
ENV PATH      $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
WORKDIR $NVM_DIR
RUN curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash \
    && . $NVM_DIR/nvm.sh \
    && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

WORKDIR /root

## switch to force gitbook update
ARG FORCE_UPDATE="not given"

## setup gitbook
ENV ARANGO_SUPPORTED_BRANCHES "3.0 3.1 3.2 3.3 3.4 devel" 
ENV ARANGO_CACHE_BASE "/root/gitbook_cache" 
COPY setup_gitbook /setup_gitbook
RUN /setup_gitbook

## other setup - ditaa, lockfile, bash_lib
COPY setup /setup
RUN /setup


## setup entrypoint
COPY entrypoint /root/entrypoint
ENTRYPOINT [ "/root/entrypoint" ]
