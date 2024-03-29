# shellcheck shell=bash

cite about-plugin
about-plugin 'OSX specific functions'

# OS X: Open new tabs in same directory
if [[ $(uname) = "Darwin" ]]; then
  if type update_terminal_cwd > /dev/null 2>&1 ; then
    if ! [[ $PROMPT_COMMAND =~ (^|;)update_terminal_cwd($|;) ]] ; then
      PROMPT_COMMAND="${PROMPT_COMMAND%;};update_terminal_cwd"
      declared="$(declare -p PROMPT_COMMAND)"
      [[ "$declared" =~ \ -[aAilrtu]*x[aAilrtu]*\  ]] 2>/dev/null
      [[ $? -eq 0 ]] && export PROMPT_COMMAND
    fi
  fi
fi

tab () {
  about 'Opens a new terminal tab'
  group 'OSX'

  osascript 2>/dev/null <<EOF
    tell application "System Events"
      tell process "Terminal" to keystroke "t" using command down
    end
    tell application "Terminal"
      activate
      do script with command " cd \"$PWD\"; $*" in window 0
    end tell
EOF
}

# renames the current os x terminal tab title
tabname () {
  printf "\e]1;$1\a"
}

# renames the current os x terminal window title
winname () {
  printf "\e]2;$1\a"
}

# this one switches your os x dock between 2d and 3d
# thanks to savier.zwetschge.org
dock-switch () {
    about 'Switch dock between 2d and 3d'
    example '$ dock-switch 2d'
    group 'OSX'

    if [[ $(uname) = "Darwin" ]]; then

        if [[ $1 = 3d ]] ; then
            defaults write com.apple.dock no-glass -boolean NO
            killall Dock

        elif [[ $1 = 2d ]] ; then
            defaults write com.apple.dock no-glass -boolean YES
            killall Dock

        else
            echo "usage:"
            echo "dock-switch 2d"
            echo "dock-switch 3d."
        fi
    else
        echo "Sorry, this only works on Mac OS X"
    fi
}

pman () {
    about 'View man documentation in Preview'
    example '$ pman bash'
    group 'OSX'
    man -t "${1}" | open -fa $PREVIEW
}

pri () {
    about 'display information about Ruby classes, modules, or methods, in Preview'
    param '1: Ruby method, module, or class'
    example '$ pri Array'
    group 'OSX'
    ri -T "${1}" | open -fa $PREVIEW
}

# Download a file and open it in Preview
prevcurl () {
  about 'Download a file and open it in Preview'
  group 'OSX'

  if [[ ! $(uname) = "Darwin" ]]
  then
    echo "This only works with Mac OS X"
    return 1
  fi
  curl "$*" | open -fa $PREVIEW
}

refresh-launchpad () {
  about 'Reset launchpad layout in macOS'
  example '$ refresh-launchpad'
  group 'OSX'

  if [[ $(uname) = "Darwin" ]];then
    defaults write com.apple.dock ResetLaunchPad -bool TRUE
    killall Dock
  else
    echo "Sorry, this only works on Mac OS X"
  fi
}

list-jvms () {
  about 'List java virtual machines and their states in macOS'
  example 'list-jvms'
  group 'OSX'

  JVMS_DIR="/Library/Java/JavaVirtualMachines"
  JVMS=( $(ls ${JVMS_DIR}) )
  JVMS_STATES=()

  # Map state of JVM
  for (( i = 0; i < ${#JVMS[@]}; i++ )); do
    if [[ -f "${JVMS_DIR}/${JVMS[$i]}/Contents/Info.plist" ]]; then
      JVMS_STATES[${i}]=enabled
    else
      JVMS_STATES[${i}]=disabled
    fi
      echo "${i} ${JVMS[$i]} ${JVMS_STATES[$i]}"
  done
}

pick-default-jvm () {
  about 'Pick the default Java Virtual Machines in system-wide scope in macOS'
  example 'pick-default-jvm'

  # Call for listing
  list-jvms

  # Declare variables
  local DEFAULT_JVM_DIR=""
  local DEFAULT_JVM=""
  local OPTION=""

  # OPTION for default jdk and set variables
  while [[ ! "$OPTION" =~ ^[0-9]+$ || OPTION -ge "${#JVMS[@]}" ]]; do
    read -p "Enter Default JVM: "  OPTION
      if [[ ! "$OPTION" =~ ^[0-9]+$  ]]; then
        echo "Please enter a number"
      fi

      if [[ OPTION -ge "${#JVMS[@]}" ]]; then
        echo "Please select one of the displayed JVMs"
      fi
  done

  DEFAULT_JVM_DIR="${JVMS_DIR}/${JVMS[$OPTION]}"
  DEFAULT_JVM="${JVMS[$OPTION]}"

  # Disable all jdk
  for (( i = 0; i < ${#JVMS[@]}; i++ )); do
    if [[ -f "${JVMS_DIR}/${JVMS[$i]}/Contents/Info.plist" ]]; then
      sudo mv "${JVMS_DIR}/${JVMS[$i]}/Contents/Info.plist" "${JVMS_DIR}/${JVMS[$i]}/Contents/Info.plist.disable"
    fi
  done

  # Enable default jdk
  if [[ -f "${DEFAULT_JVM_DIR}/Contents/Info.plist.disable" ]]; then
    sudo mv "${DEFAULT_JVM_DIR}/Contents/Info.plist.disable" "${DEFAULT_JVM_DIR}/Contents/Info.plist"
    echo "Enabled ${DEFAULT_JVM} as default JVM"
  fi
}

# Make this backwards compatible
alias pcurl='prevcurl'

# From http://apple.stackexchange.com/questions/110343/copy-last-command-in-terminal
copyLastCmd () {
  fc -ln -1 | awk '{$1=$1}1' | pbcopy
}
