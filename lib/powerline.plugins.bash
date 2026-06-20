# shellcheck shell=bash

cite about-plugin
about-plugin 'Enables powerline daemon'

_command_exists powerline-daemon || return 0
powerline-daemon -q

#the following should not be executed if bashit powerline themes in use
case "${GAUDI_BASH_THEME:-${BASH_IT_THEME:-}}" in
	*powerline*)
			return 0
		;;
esac
export POWERLINE_BASH_CONTINUATION=1
export POWERLINE_BASH_SELECT=1
bashPowerlineInit="$("${PYTHON:-python}" -c \
	"import os; \
	import powerline;\
	print(os.path.join(os.path.dirname(\
	powerline.__file__),\
	'bindings', \
	'bash', \
	'powerline.sh'))")"
[[ -e "$bashPowerlineInit" ]] || return 0
# shellcheck source=/dev/null
source "$bashPowerlineInit"
