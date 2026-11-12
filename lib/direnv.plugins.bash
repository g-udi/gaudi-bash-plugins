# shellcheck shell=bash

cite about-plugin
about-plugin 'Load direnv, if you are using it: https://direnv.net/'

if command -v direnv > /dev/null 2>&1; then
  # Ask for the hook of the shell that is running (bash or zsh)
  _gaudi_direnv_shell="${ZSH_VERSION:+zsh}"
  eval "$(direnv hook "${_gaudi_direnv_shell:-bash}")"
  unset _gaudi_direnv_shell
fi
