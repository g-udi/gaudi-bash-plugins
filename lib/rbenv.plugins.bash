# shellcheck shell=bash

cite about-plugin
about-plugin 'Ruby Version Manager via rbenv'

export RBENV_ROOT="${RBENV_ROOT:-$HOME/.rbenv}"
pathmunge "$RBENV_ROOT/bin"

if command -v rbenv > /dev/null 2>&1; then
  # Ask for the init code of the shell that is running (bash or zsh)
  _gaudi_rbenv_shell="${ZSH_VERSION:+zsh}"
  eval "$(rbenv init - "${_gaudi_rbenv_shell:-bash}")"
  unset _gaudi_rbenv_shell
fi
