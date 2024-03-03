# shellcheck shell=bash

cite about-plugin
about-plugin 'Load nodenv | Node.js virtual environment builder'

export NODENV_ROOT="$HOME/.nodenv"
pathmunge "$NODENV_ROOT/bin"

[[ `which nodenv` ]] && eval "$(nodenv init - bash)"
