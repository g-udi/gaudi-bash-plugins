# shellcheck shell=bash
# shellcheck disable=SC1091

cite about-plugin
about-plugin 'Load chruby (from /usr/local/share/chruby)'

if [[ -f /usr/local/share/chruby/chruby.sh ]]; then
  source /usr/local/share/chruby/chruby.sh
fi

if [[ -f /usr/local/share/chruby/auto.sh ]]; then
  source /usr/local/share/chruby/auto.sh
fi
