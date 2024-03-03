# shellcheck shell=bash

cite about-plugin
about-plugin 'Miscellaneous tools'

ips () {
    about 'Display all ip addresses for this host'
    group 'Misc'

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
    group 'Misc'

    curl -Ls "http://downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

myip () {
    about 'Displays your ip address, as seen by the Internet'
    group 'Misc'

    list=("http://myip.dnsomatic.com/" "http://checkip.dyndns.com/" "http://checkip.dyndns.org/")
    for url in ${list[*]}
    do
        res=$(curl -fs "${url}")
        if [[ $? -eq 0 ]];then
            break;
        fi
    done
    res=$(echo "$res" | grep -Eo '[0-9\.]+')
    echo -e "Your public IP is: ${GREEN} $res ${NC}"
}

pickfrom () {
    about 'Picks random line from file'
    example '$ pickfrom /usr/share/dict/words'
    group 'Misc'

    local file=$1
    [[ -z "$file" ]] && reference $FUNCNAME && return
    length=$(cat $file | wc -l)
    n=$(expr $RANDOM \* $length \/ 32768 + 1)
    head -n $n $file | tail -1
}

passgen () {
    about 'Generates random password from dictionary words'
    example '$ passgen 6'
    group 'Misc'

    local i pass length=${1:-4}
    pass=$(echo $(for i in $(eval echo "{1..$length}"); do pickfrom /usr/share/dict/words; done))

    echo "With spaces (easier to memorize): $pass"
    echo "Without (use this as the password): $(echo $pass | tr -d ' ')"
}

pmdown () {
    about 'Preview markdown file in a browser'
    example '$ pmdown README.md'
    group 'Misc'

    if command -v markdown &>/dev/null
    then
      markdown $1 | browser
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
    group 'Misc'

    mkdir -p -- "$@" && eval cd -- "\"\$$#\""
}

lsgrep () {
    about 'Search through directory contents with grep'
    group 'Misc'

    ls | grep "$*"
}

quiet () {
    about 'What *does* this do?'
    group 'Misc'

    "$*" &> /dev/null &
}

usage () {
    about 'Disk usage per directory, in Mac OS X and Linux'
    param '1: directory name'
    group 'Misc'

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

command_exists () {
    about 'Checks for existence of a command'
    example '$ command_exists ls && echo exists'
    group 'Misc'

    type "$1" &> /dev/null ;
}

mkiso () {
    about 'Creates iso from current dir in the parent dir (unless defined)'
    example 'mkiso ISO-Name dest/path src/path'
    group 'Misc'

    if type "mkisofs" > /dev/null; then
        [[ -z ${1+x} ]] && local isoname=${PWD##*/} || local isoname=$1
        [[ -z ${2+x} ]] && local destpath=../ || local destpath=$2
        [[ -z ${3+x} ]] && local srcpath=${PWD} || local srcpath=$3

        if [[ ! -f "${destpath}${isoname}.iso" ]]; then
            echo "writing ${isoname}.iso to ${destpath} from ${srcpath}"
            mkisofs -V ${isoname} -iso-level 3 -r -o "${destpath}${isoname}.iso" "${srcpath}"
        else
            echo "${destpath}${isoname}.iso already exists"
        fi
    else
        echo "mkisofs cmd does not exist, please install cdrtools"
    fi
}

buf () {
    about 'Backup file with timestamp'
    group 'Misc'

    local filename filetime

    filename=$1
    filetime=$(date +%Y%m%d_%H%M%S)
    cp -a "${filename}" "${filename}_${filetime}"
}

del () {
    about 'Move files to hidden folder in tmp, that gets cleared on each reboot'
    example 'del ./file.txt'
    group 'Misc'

    mkdir -p /tmp/.trash && mv "$@" /tmp/.trash;
}
