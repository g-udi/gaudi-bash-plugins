# shellcheck shell=bash

cite about-plugin
about-plugin 'Enables powerline daemon'

# Bash only: this loads powerline's bash bindings
[[ -n "${BASH_VERSION:-}" ]] || return 0

_binary_exists powerline-daemon || return 0
powerline-daemon -q

# The following should not be executed if a powerline theme of the framework is
# in use (THEME setting; the legacy BASH_IT_THEME is still read)
_gaudi_powerline_theme="$(_gaudi_host_setting THEME)"
case "${_gaudi_powerline_theme:-${BASH_IT_THEME:-}}" in
	*powerline*)
		unset _gaudi_powerline_theme
		return 0
		;;
esac
unset _gaudi_powerline_theme
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1

# The path of powerline's bash bindings is asked from Python once and then kept
# in a cache file, so no Python process is started at every shell start
_gaudi_powerline_cache="${XDG_CACHE_HOME:-$HOME/.cache}/${GAUDI_HOST_NAME:-gaudi}/powerline-bash-init"
_gaudi_powerline_init=""
if [[ -r "$_gaudi_powerline_cache" ]]; then
	_gaudi_powerline_init="$(< "$_gaudi_powerline_cache")"
fi
if [[ ! -e "$_gaudi_powerline_init" ]]; then
	_gaudi_powerline_init="$("${PYTHON:-python3}" -c \
		"import os; \
		import powerline;\
		print(os.path.join(os.path.dirname(\
		powerline.__file__),\
		'bindings', \
		'bash', \
		'powerline.sh'))" 2> /dev/null)"
	if [[ -e "$_gaudi_powerline_init" ]] && mkdir -p "${_gaudi_powerline_cache%/*}" 2> /dev/null; then
		printf '%s\n' "$_gaudi_powerline_init" > "$_gaudi_powerline_cache"
	fi
fi
unset _gaudi_powerline_cache
if [[ ! -e "$_gaudi_powerline_init" ]]; then
	unset _gaudi_powerline_init
	return 0
fi
# shellcheck source=/dev/null
source "$_gaudi_powerline_init"
unset _gaudi_powerline_init
