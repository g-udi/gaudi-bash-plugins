# shellcheck shell=bash
# shellcheck disable=SC1090,SC2154

cite about-plugin
about-plugin 'Ruby Version Manager (RVM)'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Check to make sure that RVM is actually loaded before adding the customizations to it
if [[ "$rvm_path" ]]
then
    # Load the auto-completion script if RVM was loaded.
    [[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

    switch () {
      rvm $1
      local v
      v=$(rvm_version)
      rvm wrapper $1 textmate
      echo "Switch to Ruby version: $v"
    }

    rvm_default () {
      rvm --default $1
      rvm wrapper $1 textmate
    }

    rvm_version () {
      ruby --version
    }

fi
