#! /bin/bash
set -e

: ${APP_PATH:="/finances-api"}
: ${APP_TEMP_PATH:="$APP_PATH/tmp"}
: ${APP_SETUP_LOCK:="$APP_TEMP_PATH/setup.lock"}
: ${APP_SETUP_WAIT:="5"}

function lock_setup { mkdir -p $APP_TEMP_PATH && touch $APP_SETUP_LOCK; }
function unlock_setup { rm -rf $APP_SETUP_LOCK; }
function wait_setup { echo "Waiting for app setup to finish..."; sleep $APP_SETUP_WAIT; }

trap unlock_setup HUP INT QUIT KILL TERM EXIT

echo "DB is not ready, sleeping..."
until nc -vz db 5432 &>/dev/null; do
  sleep 1
done
echo "DB is ready, starting Rails."

if [ -z "$1" ]; then set -- bundle exec rails server -p 5000 -b 0.0.0.0 "$@"; fi

if [[ "$3" = "rails" ]]
then
  unlock_setup
  while [ -f $APP_SETUP_LOCK ]; do wait_setup; done

  lock_setup
  bundle install
  bundle exec rails db:prepare
  unlock_setup

  if [[ "$4" = "s" || "$4" = "server" ]]; then rm -rf /finances-api/tmp/pids/server.pid; fi
fi

exec "$@"
