# shellcheck shell=bash

cite about-plugin
about-plugin 'Initialize jump (see https://github.com/gsamokovarov/jump). Set JUMP_OPTS to change keybinding'

__init_jump () {
  command -v jump &> /dev/null || return 0
  # Ask for the integration of the shell that is running (bash or zsh)
  local shell_name="${ZSH_VERSION:+zsh}"
  eval "$(jump shell "${shell_name:-bash}" "${JUMP_OPTS[@]}")"
}

__init_jump
