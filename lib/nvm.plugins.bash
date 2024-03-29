# shellcheck shell=bash

cite about-plugin priority
about-plugin 'Node version manager configuration'
priority "250"

export NVM_DIR=${NVM_DIR:-$HOME/.nvm}
# This loads nvm
if command -v brew &>/dev/null && [[ -s $(brew --prefix nvm)/nvm.sh ]]
then
  . $(brew --prefix nvm)/nvm.sh
else
  [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
fi

if ! command -v nvm &>/dev/null
then
  nvm () {
    echo "gaudi-bash no longer bundles the nvm script. Please install the latest version from"
    echo ""
    echo "https://github.com/creationix/nvm.git"
    echo ""
    echo "if you want to use nvm. You can keep this plugin enabled once you have installed nvm."
  }

  nvm
fi
