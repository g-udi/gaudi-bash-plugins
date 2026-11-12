# shellcheck shell=bash

cite about-plugin
about-plugin 'Initialization for fuck'

# https://github.com/nvbn/thefuck

# `thefuck --alias` starts Python, so it is not run when the shell starts: the
# first call of `fuck` replaces this stub with the real function and runs it
if _binary_exists thefuck; then
  fuck () {
    unset -f fuck
    eval "$(thefuck --alias)"
    fuck "$@"
  }
fi
