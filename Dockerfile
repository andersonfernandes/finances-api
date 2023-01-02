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
