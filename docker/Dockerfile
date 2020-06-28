ARG RUBY_VERSION=2.6.5
FROM ruby:$RUBY_VERSION
ARG DEBIAN_FRONTEND=noninteractive

ARG NODE_VERSION=12
RUN curl -sL https://deb.nodesource.com/setup_$NODE_VERSION.x | bash -

RUN apt-get update && apt-get install -y \
      build-essential \
      nodejs \
      locales \
      netcat \
      vim \
      sudo

ARG UID
ENV UID $UID
ARG GID
ENV GID $GID
ARG USER=ruby
ENV USER $USER

RUN groupadd -g $GID $USER && \
      useradd -u $UID -g $USER -m $USER && \
      usermod -p "*" $USER && \
      usermod -aG sudo $USER && \
      echo "$USER ALL=NOPASSWD: ALL" >> /etc/sudoers.d/50-$USER

ENV LANG C.UTF-8

ENV BUNDLE_PATH /gems
ENV BUNDLE_HOME /gems

ARG BUNDLE_JOBS=20
ENV BUNDLE_JOBS $BUNDLE_JOBS
ARG BUNDLE_RETRY=5
ENV BUNDLE_RETRY $BUNDLE_RETRY

ENV GEM_HOME /gems
ENV GEM_PATH /gems

ENV PATH /gems/bin:$PATH

RUN mkdir -p "$GEM_HOME" && chown $USER:$USER "$GEM_HOME"
RUN mkdir -p /finances-api && chown $USER:$USER /finances-api

WORKDIR /finances-api

RUN mkdir -p tmp/cache && chown $USER:$USER tmp/cache

USER $USER

RUN gem install bundler
