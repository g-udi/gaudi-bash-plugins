

# shellcheck shell=bash
# shellcheck disable=SC1090

cite about-plugin priority
about-plugin 'Load fzf, a Command-line fuzzy finder written in Go'
# Load after the system completion to make sure that the fzf completions are working
priority "375"

_command_exists fzf || return

if [[ -r ~/.fzf.bash ]] ; then
  source ~/.fzf.bash
elif [[ -r "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash ]] ; then
  source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.bash
fi

if [[ -z ${FZF_DEFAULT_COMMAND+x}  ]] && _command_exists fd ; then
  export FZF_DEFAULT_COMMAND='fd --type f'
fi

fe () {
  about "Open the selected file in the default editor"
  group "FZF"
  param "1: Search term"
  example "fe foo"

  local IFS=$'\n'
  local files
  files=("$(fzf-tmux --query="$1" --multi --select-1 --exit-0)")
  [[ -n "${files[*]}" ]] && ${EDITOR:-vim} "${files[@]}"
}

fcd () {
  about "cd to the selected directory"
  group "FZF"
  param "1: Directory to browse, or . if omitted"
  example "fcd aliases"

  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir" || return
}
