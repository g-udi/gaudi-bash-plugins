# shellcheck shell=bash

cite about-plugin
about-plugin 'Miscellaneous tools'

ips () {
    about 'Display all ip addresses for this host'
    group 'base'

    if command -v ifconfig &>/dev/null
    then
        ifconfig | awk '/inet /{ gsub(/addr:/, ""); print $2 }'
    elif command -v ip &>/dev/null
    then
        ip addr | grep -oP 'inet \K[\d.]+'
    else
        echo "You don't have ifconfig or ip command installed!"
    fi
}

down4me () {
    about 'Checks whether a website is down for you, or everybody'
    example '$ down4me http://www.google.com'
    group 'base'

    curl -Ls "http://downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

myip () {
    about 'Displays your ip address, as seen by the Internet'
    group 'base'

    local list res url
    list=("http://myip.dnsomatic.com/" "http://checkip.dyndns.com/" "http://checkip.dyndns.org/")
    for url in "${list[@]}"; do
        if res=$(curl -fs "${url}"); then
            break;
        fi
    done
    res=$(echo "$res" | grep -Eo '[0-9\.]+')
    echo -e "Your public IP is: ${GREEN} $res ${NC}"
}

pickfrom () {
    about 'Picks random line from file'
    example '$ pickfrom /usr/share/dict/words'
    group 'base'

    local file=$1 length n
    [[ -z "$file" ]] && reference "${FUNCNAME[0]}" && return
    if [[ ! -r "$file" ]]; then
        echo "pickfrom: cannot read $file" >&2
        return 1
    fi
    length=$(wc -l < "$file")
    if ((length <= 0)); then
        echo "pickfrom: $file is empty" >&2
        return 1
    fi
    n=$((RANDOM * length / 32768 + 1))
    head -n "$n" "$file" | tail -1
}

passgen () {
    about 'Generates random password from dictionary words'
    example '$ passgen 6'
    group 'base'

    local _ pass="" word length=${1:-4}
    for ((_ = 0; _ < length; _++)); do
        word=$(pickfrom /usr/share/dict/words) || return
        pass+="${word} "
    done
    pass="${pass% }"

    echo "With spaces (easier to memorize): $pass"
    echo "Without (use this as the password): $(echo "$pass" | tr -d ' ')"
}

pmdown () {
    about 'Preview markdown file in a browser'
    example '$ pmdown README.md'
    group 'base'

    if command -v markdown &>/dev/null
    then
      local html="${TMPDIR:-/tmp}/pmdown-${1##*/}.html"
      markdown "$1" > "$html" || return 1
      if command -v open &>/dev/null; then
        open "$html"
      elif command -v xdg-open &>/dev/null; then
        xdg-open "$html"
      else
        echo "Preview written to $html"
      fi
    else
      echo "You don't have a markdown command installed!"
    fi
}

mkcd () {
    about 'Make one or more directories and cd into the last one'
    example '$ mkcd foo'
    example '$ mkcd /tmp/img/photos/large'
    example '$ mkcd foo foo1 foo2 fooN'
    example '$ mkcd /tmp/img/photos/large /tmp/img/photos/self /tmp/img/photos/Beijing'
    group 'base'

    mkdir -p -- "$@" && eval cd -- "\"\$$#\""
}

lsgrep () {
    about 'Search through directory contents with grep'
    group 'base'

    find . -maxdepth 1 -mindepth 1 -print | sed 's#^\./##' | grep -- "$*"
}

quiet () {
    about 'Runs a command in the background with all of its output discarded'
    example '$ quiet open-some-gui-app'
    group 'base'

    (($#)) || return 1
    "$@" &> /dev/null &
}

usage () {
    about 'Disk usage per directory, in Mac OS X and Linux'
    param '1: directory name'
    group 'base'

    if [[ $(uname) = "Darwin" ]]; then
        if [[ -n "$1" ]]; then
            du -hd 1 "$1"
        else
            du -hd 1
        fi

    elif [[ $(uname) = "Linux" ]]; then
        if [[ -n "$1" ]]; then
            du -h --max-depth=1 "$1"
        else
            du -h --max-depth=1
        fi
    fi
}

mkiso () {
    about 'Creates iso from current dir in the parent dir (unless defined)'
    example 'mkiso ISO-Name dest/path src/path'
    group 'base'

    if type "mkisofs" > /dev/null; then
        local isoname="${1:-${PWD##*/}}"
        local destpath="${2:-../}"
        local srcpath="${3:-${PWD}}"

        if [[ ! -f "${destpath}${isoname}.iso" ]]; then
            echo "writing ${isoname}.iso to ${destpath} from ${srcpath}"
            mkisofs -V "${isoname}" -iso-level 3 -r -o "${destpath}${isoname}.iso" "${srcpath}"
        else
            echo "${destpath}${isoname}.iso already exists"
        fi
    else
        echo "mkisofs cmd does not exist, please install cdrtools"
    fi
}

buf () {
    about 'Backup file with timestamp'
    group 'base'

    local filename filetime

    filename=$1
    filetime=$(date +%Y%m%d_%H%M%S)
    cp -a "${filename}" "${filename}_${filetime}"
}

del () {
    about 'Move files to hidden folder in tmp, that gets cleared on each reboot'
    example 'del ./file.txt'
    group 'base'

    mkdir -p /tmp/.trash && mv "$@" /tmp/.trash;
}
