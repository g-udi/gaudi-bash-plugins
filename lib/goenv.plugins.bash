# shellcheck shell=bash

cite about-plugin
about-plugin 'Load Go version management via goenv'

# Don't modify the environment if we can't find the tool:
# - Check if in $PATH already
# - Check if installed manually to $GOENV_ROOT
# - Check if installed manually to $HOME
_binary_exists goenv ||
  [[ -n "${GOENV_ROOT:-}" && -x "$GOENV_ROOT/bin/goenv" ]] ||
  [[ -x "$HOME/.goenv/bin/goenv" ]] ||
  return 0

# Set GOENV_ROOT, if not already set
export GOENV_ROOT="${GOENV_ROOT:-$HOME/.goenv}"

# Add GOENV_ROOT/bin to PATH, if that's where it's installed
! _binary_exists goenv && [[ -x "$GOENV_ROOT/bin/goenv" ]] && pathmunge "$GOENV_ROOT/bin"

# Initialize goenv for the shell that is running (bash or zsh)
_gaudi_goenv_shell="${ZSH_VERSION:+zsh}"
eval "$(goenv init - "${_gaudi_goenv_shell:-bash}")"
unset _gaudi_goenv_shell
