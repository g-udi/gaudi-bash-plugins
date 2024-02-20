cite about-plugin
about-plugin 'Miscellaneous tools'

ips () {
    about 'display all ip addresses for this host'
    group 'plugin:base'

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
    about 'checks whether a website is down for you, or everybody'
    param '1: website url'
    example '$ down4me http://www.google.com'
    group 'plugin:base'

    curl -Ls "http://downforeveryoneorjustme.com/$1" | sed '/just you/!d;s/<[^>]*>//g'
}

myip () {
    about 'displays your ip address, as seen by the Internet'
    group 'plugin:base'

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
    about 'picks random line from file'
    param '1: filename'
    example '$ pickfrom /usr/share/dict/words'
    group 'plugin:base'

    local file=$1
    [[ -z "$file" ]] && reference $FUNCNAME && return
    length=$(cat $file | wc -l)
    n=$(expr $RANDOM \* $length \/ 32768 + 1)
    head -n $n $file | tail -1
}

passgen () {
    about 'generates random password from dictionary words'
    param 'optional integer length'
    param 'if unset, defaults to 4'
    example '$ passgen'
    example '$ passgen 6'
    group 'plugin:base'

    local i pass length=${1:-4}
    pass=$(echo $(for i in $(eval echo "{1..$length}"); do pickfrom /usr/share/dict/words; done))
    echo "With spaces (easier to memorize): $pass"
    echo "Without (use this as the password): $(echo $pass | tr -d ' ')"
}

# Create alias pass to passgen when pass isn't installed or
# BASH_IT_LEGACY_PASS is true.
if ! command -v pass &>/dev/null || [[ "$BASH_IT_LEGACY_PASS" = true ]]
then
  alias pass=passgen
fi

pmdown () {
    about 'preview markdown file in a browser'
    param '1: markdown file'
    example '$ pmdown README.md'
    group 'plugin:base'

    if command -v markdown &>/dev/null
    then
      markdown $1 | browser
    else
      echo "You don't have a markdown command installed!"
    fi
}

mkcd () {
    about 'make one or more directories and cd into the last one'
    param 'one or more directories to create'
    example '$ mkcd foo'
    example '$ mkcd /tmp/img/photos/large'
    example '$ mkcd foo foo1 foo2 fooN'
    example '$ mkcd /tmp/img/photos/large /tmp/img/photos/self /tmp/img/photos/Beijing'
    group 'plugin:base'

    mkdir -p -- "$@" && eval cd -- "\"\$$#\""
}

lsgrep () {
    about 'search through directory contents with grep'
    group 'plugin:base'

    ls | grep "$*"
}

quiet () {
    about 'what *does* this do?'
    group 'plugin:base'

    "$*" &> /dev/null &
}

usage () {
    about 'disk usage per directory, in Mac OS X and Linux'
    param '1: directory name'
    group 'plugin:base'

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

if [[ ! -e "${BASH_IT}/plugins/enabled/todo.plugin.bash" ]] && [[ ! -e "${BASH_IT}/plugins/enabled/*${GAUDI_BASH_LOAD_PRIORITY_SEPARATOR}todo.plugin.bash" ]]; then
# if user has installed todo plugin, skip this...
    t () {
        about 'one thing todo'
        param 'if not set, display todo item'
        param '1: todo text'
        if [[ "$*" == "" ]] ; then
            cat ~/.t
        else
            echo "$*" > ~/.t
        fi
    }
fi

command_exists () {
    about 'checks for existence of a command'
    param '1: command to check'
    example '$ command_exists ls && echo exists'
    group 'plugin:base'

    type "$1" &> /dev/null ;
}

mkiso () {
    about 'creates iso from current dir in the parent dir (unless defined)'
    param '1: ISO name'
    param '2: dest/path'
    param '3: src/path'
    example 'mkiso'
    example 'mkiso ISO-Name dest/path src/path'
    group 'plugin:base'

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

# useful for administrators and configs
buf () {
    about 'back up file with timestamp'
    param 'filename'
    group 'plugin:base'

    local filename filetime

    filename=$1
    filetime=$(date +%Y%m%d_%H%M%S)
    cp -a "${filename}" "${filename}_${filetime}"
}

del () {
    about 'move files to hidden folder in tmp, that gets cleared on each reboot'
    param 'file or folder to be deleted'
    example 'del ./file.txt'
    group 'plugin:base'

    mkdir -p /tmp/.trash && mv "$@" /tmp/.trash;
}
