#! /bin/bash

show_loading_while_starting() {
  local message="${2:-Starting app}"
  local delay="0.1"
  tput civis
  printf "\n\033[1;32m"

  while docker ps | grep -oq finances-api-web-1 && ! docker logs finances-api-web-1 | grep -oq DOCKER_STARTED
  do
    printf '\033[s\033[u[ / ] %s\033[u' "$message"; sleep "$delay"
    printf '\033[s\033[u[ — ] %s\033[u' "$message"; sleep "$delay"
    printf '\033[s\033[u[ \ ] %s\033[u' "$message"; sleep "$delay"
    printf '\033[s\033[u[ | ] %s\033[u' "$message"; sleep "$delay"
  done

  printf '\033[s\033[u%*s\033[u\033[0m' $((${#message}+6)) " "
  tput cnorm

  return 0
}

printf "Raising infrastructure ...\n\n"

if ! docker ps -a | grep -oq finances-api-web-1; then
  docker compose up -d 

  show_loading_while_starting
else
  docker compose start && echo
fi

printf "\033[1;32m ... done!\e[0m\n"

docker attach finances-api-web-1
