# shellcheck shell=bash

cite about-plugin
about-plugin 'Go environment variables & path configuration'

command -v go &>/dev/null || return 0

_go_pathmunge_wrap () {
  local IFS=':'
  local -a paths
  read -r -a paths <<< "$1"
  local i=${#paths[@]}
  while [[ $i -gt 0 ]] ; do
    i=$(( i - 1 ))
    pathmunge "${paths[i]}/bin"
  done
}

export GOROOT="${GOROOT:-$(go env GOROOT)}"
export GOPATH="${GOPATH:-$(go env GOPATH)}"
_go_pathmunge_wrap "${GOPATH}:${GOROOT}"
