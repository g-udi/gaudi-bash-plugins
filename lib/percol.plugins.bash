# shellcheck shell=bash

cite about-plugin
about-plugin 'Search & Select history with percol'

# Notice: You have to upgrade bash to bash 4.x on Mac OS X (http://stackoverflow.com/questions/16416195/how-do-i-upgrade-bash-in-mac-osx-mountain-lion-and-set-it-the-correct-path)

_replace_by_history () {
    if command -v tac>/dev/null; then
        alias _tac=tac
    else
        alias _tac="tail -r"
    fi
    local l=$(HISTTIMEFORMAT= history | _tac | sed -e 's/^\ *[0-9]*\ *//' | percol --query "$READLINE_LINE")
    READLINE_LINE="$l"
    READLINE_POINT=${#l}
}


if command -v percol>/dev/null; then
    current_version=${BASH_VERSION%%[^0-9]*}
    if [[ $current_version -lt 4 ]]; then
       echo -e "Warning: You have to upgrade Bash to Bash v4.x to use the 'percol' plugin"
       echo -e "         Your current Bash version is $BASH_VERSION"
    else
        bind -x '"\C-r": _replace_by_history'
    fi
fi
