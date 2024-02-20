cite about-plugin
about-plugin 'history manipulation'

_bash_history_sync () {
  builtin history -a         #1
  HISTFILESIZE=$HISTSIZE     #2
  builtin history -c         #3
  builtin history -r         #4
}

history () {                  #5
  _bash_history_sync
  builtin history "$@"
}

PROMPT_COMMAND=_bash_history_sync

# Save and reload the history after each command finishes
export PROMPT_COMMAND="_bash_history_sync; $PROMPT_COMMAND"
