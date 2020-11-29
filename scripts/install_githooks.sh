#!/usr/bin/env bash

GIT_CONFIG_DIR=$(git rev-parse --git-dir)
ROOT_DIR=$(git rev-parse --show-toplevel)

echo "Installing hooks..."
ln -sf $ROOT_DIR/scripts/pre_commit.sh $GIT_CONFIG_DIR/hooks/pre-commit
ln -sf $ROOT_DIR/scripts/pre_push.sh $GIT_CONFIG_DIR/hooks/pre-push
echo "Done!"
