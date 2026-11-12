# shellcheck shell=bash
# shellcheck disable=SC1090

cite about-plugin
about-plugin 'Autojump configuration [ref: https://github.com/wting/autojump]'

# Only supports the Homebrew variant, Debian and Arch at the moment.
# Feel free to provide a PR to support other install locations

# Homebrew: the prefix comes from the environment or the usual locations, so
# `brew` is not run at every shell start
_gaudi_autojump_script=""
for _gaudi_autojump_prefix in "${GAUDI_HOST_HOMEBREW_PREFIX:-}" "${HOMEBREW_PREFIX:-}" /opt/homebrew /usr/local /home/linuxbrew/.linuxbrew; do
  if [[ -n "$_gaudi_autojump_prefix" && -s "${_gaudi_autojump_prefix}/etc/profile.d/autojump.sh" ]]; then
    _gaudi_autojump_script="${_gaudi_autojump_prefix}/etc/profile.d/autojump.sh"
    break
  fi
done
unset _gaudi_autojump_prefix

if [[ -n "$_gaudi_autojump_script" ]]; then
  # shellcheck source=/dev/null
  source "$_gaudi_autojump_script"
elif command -v dpkg &>/dev/null && dpkg -s autojump &>/dev/null ; then
  # shellcheck source=/dev/null
  source "$(dpkg-query -S autojump.sh | cut -d' ' -f2)"
elif command -v pacman &>/dev/null && pacman -Q autojump &>/dev/null ; then
  # shellcheck source=/dev/null
  source "$(pacman -Ql autojump | grep autojump.sh | cut -d' ' -f2)"
fi
unset _gaudi_autojump_script
