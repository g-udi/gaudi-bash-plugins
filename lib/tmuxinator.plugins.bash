# shellcheck shell=bash
# shellcheck disable=SC1090

cite about-plugin
about-plugin 'Sources tmuxinator script if available'

if [[ -s "$HOME/.tmuxinator/scripts/tmuxinator" ]]; then
  # shellcheck source=/dev/null
  . "$HOME/.tmuxinator/scripts/tmuxinator"
fi
