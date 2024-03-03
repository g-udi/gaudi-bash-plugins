# shellcheck shell=bash

cite about-plugin
about-plugin 'Python version management via pyenv'

export PYENV_ROOT="$HOME/.pyenv"
pathmunge "$PYENV_ROOT/bin"

[[ `which pyenv 2>/dev/null` ]] && eval "$(pyenv init - bash)"

# Load pyenv virtualenv if the virtualenv plugin is installed.
if pyenv virtualenv-init - &> /dev/null; then
  eval "$(pyenv virtualenv-init - bash)"
fi
