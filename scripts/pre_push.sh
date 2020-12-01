#! /bin/bash

printf "\n\e[1;34mRunning tests before push\e[0m\n\n"

ROOT_DIR=$(git rev-parse --show-toplevel)
source $ROOT_DIR/scripts/start_app.sh

if ! docker-compose exec -T web bundle exec rspec; then
  printf "\n\e[1;31mFix the tests before push!\e[0m\n\n"
  exit 1
fi
