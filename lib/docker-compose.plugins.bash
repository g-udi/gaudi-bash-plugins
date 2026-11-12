# shellcheck shell=bash

cite about-plugin
about-plugin 'Helper functions for using docker-compose'

docker-compose-fresh () {
  about 'Shut down, remove and start again the docker-compose setup, then tail the logs'
  group 'docker-compose'
  example 'docker-compose-fresh docker-compose-foo.yaml'

  # "docker compose" (the CLI plugin) when docker has it, else the standalone
  # docker-compose binary
  local -a dco dco_file_param
  dco=(docker-compose)
  if docker compose version > /dev/null 2>&1; then
    dco=(docker compose)
  fi
  dco_file_param=()
  if [[ -n "${1:-}" ]]; then
    echo "Using docker-compose file: $1"
    dco_file_param=(--file "$1")
  fi

  "${dco[@]}" "${dco_file_param[@]}" stop
  "${dco[@]}" "${dco_file_param[@]}" rm -f
  "${dco[@]}" "${dco_file_param[@]}" up -d
  "${dco[@]}" "${dco_file_param[@]}" logs -f --tail 100
}
