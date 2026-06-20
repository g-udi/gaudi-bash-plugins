# shellcheck shell=bash
# shellcheck disable=SC1090,SC2154

cite about-plugin
about-plugin 'Ruby Version Manager (RVM)'

if [[ -s "$HOME/.rvm/scripts/rvm" ]]; then
  # shellcheck source=/dev/null
  source "$HOME/.rvm/scripts/rvm"
fi

# Check to make sure that RVM is actually loaded before adding the customizations to it
if [[ "$rvm_path" ]]
then
    # Load the auto-completion script if RVM was loaded.
    if [[ -r "$rvm_path/scripts/completion" ]]; then
      # shellcheck source=/dev/null
      . "$rvm_path/scripts/completion"
    fi

    switch () {
      rvm "$1"
      local v
      v=$(rvm_version)
      rvm wrapper "$1" textmate
      echo "Switch to Ruby version: $v"
    }

    rvm_default () {
      rvm --default "$1"
      rvm wrapper "$1" textmate
    }

    rvm_version () {
      ruby --version
    }

fi
