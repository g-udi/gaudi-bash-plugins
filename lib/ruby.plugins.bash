# shellcheck shell=bash

cite about-plugin
about-plugin 'Ruby and rubygems specific functions and settings'

# Make commands installed with 'gem install --user-install' available:
# $GEM_HOME/bin when GEM_HOME is set, and ~/.gem/ruby/<version>/bin for every
# Ruby version that has one. The directories are found with a glob, so no
# `ruby` process is started at every shell start.
if [[ -n "${GEM_HOME:-}" && -d "${GEM_HOME}/bin" ]]; then
  pathmunge "${GEM_HOME}/bin" after
fi
for _gaudi_ruby_gem_bin in "$HOME"/.gem/ruby/*/bin; do
  [[ -d "$_gaudi_ruby_gem_bin" ]] && pathmunge "$_gaudi_ruby_gem_bin" after
done
unset _gaudi_ruby_gem_bin

remove_gem () {
  about 'Removes an installed gem (exact name) with sudo, after confirmation'
  param '1: gem name'
  group 'ruby'

  if [[ -z "${1:-}" ]]; then
    echo "Usage: remove_gem <gem name>" >&2
    return 1
  fi
  if ! gem list --no-versions | grep -qFx -- "$1"; then
    echo "remove_gem: gem '$1' is not installed" >&2
    return 1
  fi

  _read_input "Run 'sudo gem uninstall $1'? [y/n]"
  [[ "$REPLY" == [yY] ]] || return 1
  sudo gem uninstall "$1"
}
