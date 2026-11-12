# shellcheck shell=bash

cite about-plugin
about-plugin 'Go environment variables & path configuration'

command -v go &>/dev/null || return 0

_go_pathmunge_wrap () {
  # Plain parameter expansion, no arrays, so it behaves the same in bash
  # (3.2 included) and zsh. The list is walked from its last entry to its
  # first, so that prepending keeps the order in which the paths were given
  local rest="$1" dir
  while [[ -n "$rest" ]]; do
    dir="${rest##*:}"
    if [[ "$rest" == *:* ]]; then
      rest="${rest%:*}"
    else
      rest=""
    fi
    if [[ -n "$dir" ]]; then
      pathmunge "${dir}/bin"
    fi
  done
}

# Values already in the environment are kept. `go` is only asked for what is
# missing, in a single call (one line per name, in the order given).
if [[ -z "${GOROOT:-}" || -z "${GOPATH:-}" ]]; then
  _go_env="$(go env GOROOT GOPATH 2> /dev/null)"
  _go_newline='
'
  : "${GOROOT:=${_go_env%%"$_go_newline"*}}"
  : "${GOPATH:=${_go_env#*"$_go_newline"}}"
  unset _go_env _go_newline
fi
export GOROOT GOPATH
_go_pathmunge_wrap "${GOPATH}:${GOROOT}"
unset -f _go_pathmunge_wrap
