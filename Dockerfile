ARG RUBY_VERSION=3.1.2

FROM ruby:$RUBY_VERSION-alpine

RUN apk add --update --no-cache \
  bash \
  build-base \
  sudo \
  libpq-dev \
  tzdata

RUN mkdir -p /finances-api
WORKDIR /finances-api

RUN gem install bundler


# ARG RUBY_VERSION=3.1.2
# FROM ruby:$RUBY_VERSION
# ARG DEBIAN_FRONTEND=noninteractive
#
# RUN apt-get update && apt-get install -y \
#       build-essential \
#       nodejs \
#       locales \
#       netcat \
#       vim \
#       sudo \
#   && apt-get clean \
#   && rm -rf /var/cache/apt/archives/* \
#   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
#   && truncate -s 0 /var/log/*log
#
# ENV LANG C.UTF-8
#
# RUN mkdir -p /finances-api && chown $USER:$USER /finances-api
# WORKDIR /finances-api
#
# RUN gem install bundler
