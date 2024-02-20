#!/usr/bin/env bash

cite about-plugin
about-plugin 'Go environment variables & path configuration'

command -v go &>/dev/null || return

_go_pathmunge_wrap () {
  IFS=':' local -a 'a=($1)'
  local i=${#a[@]}
  while [[ $i -gt 0 ]] ; do
    i=$(( i - 1 ))
    pathmunge "${a[i]}/bin"
  done
}

export GOROOT="${GOROOT:-$(go env GOROOT)}"
export GOPATH="${GOPATH:-$(go env GOPATH)}"
_go_pathmunge_wrap "${GOPATH}:${GOROOT}"
