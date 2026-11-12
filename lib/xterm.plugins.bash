# shellcheck shell=bash

cite about-plugin
about-plugin 'Automatically set your xterm title with host and location info'

# The title is set from two hook functions, added to the precmd_functions and
# preexec_functions arrays: zsh runs these itself and bash runs them through
# bash-preexec. Functions named precmd and preexec that already exist are left
# alone.

_short-dirname () {
  # The current directory with $HOME shown as ~ (the same in bash and zsh)
  local dir_name="$PWD"

  if [[ -n "${HOME:-}" && "$dir_name" == "$HOME"* ]]; then
    dir_name="~${dir_name#"$HOME"}"
  fi
  if [[ "${SHORT_TERM_LINE:-}" = true ]] && [[ ${#dir_name} -gt 8 ]]; then
    echo "${dir_name##*/}"
  else
    echo "$dir_name"
  fi
}

_short-command () {
  local input_command="$*"

  if [[ "${SHORT_TERM_LINE:-}" = true ]] && [[ ${#input_command} -gt 8 ]]; then
    echo "${input_command%% *}"
  else
    echo "$input_command"
  fi
}

set_xterm_title () {
    about 'Sets the xterm window title'
    param '1: title'
    group 'xterm'

    local title="$1"
    printf '\033]0;%s\007' "$title"
}

_xterm_title_precmd () {
    about 'Sets the xterm title to user@host and the directory before each prompt'
    group 'xterm'

    set_xterm_title "${SHORT_USER:-${USER:-}}@${SHORT_HOSTNAME:-${HOSTNAME:-${HOST:-}}} $(_short-dirname) ${PROMPTCHAR:-}"
}

_xterm_title_preexec () {
    about 'Sets the xterm title to the command being run'
    group 'xterm'

    set_xterm_title "$(_short-command "$1") {$(_short-dirname)} (${SHORT_USER:-${USER:-}}@${SHORT_HOSTNAME:-${HOSTNAME:-${HOST:-}}})"
}

if [[ " ${precmd_functions[*]:-} " != *" _xterm_title_precmd "* ]]; then
  precmd_functions+=(_xterm_title_precmd)
fi
if [[ " ${preexec_functions[*]:-} " != *" _xterm_title_preexec "* ]]; then
  preexec_functions+=(_xterm_title_preexec)
fi
