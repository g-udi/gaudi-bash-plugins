# shellcheck shell=bash

cite about-plugin priority
about-plugin 'Load Atuin! The magical shell history (via ble.sh in bash)'
# After the blesh plugin (default priority 250), which sets BLE_VERSION
priority "260"

_binary_exists atuin || return 0

if [[ -n "${ZSH_VERSION:-}" ]]; then
	# zsh has the hooks atuin needs built in
	eval "$(atuin init zsh)"
elif [[ ${BLE_VERSION-} ]]; then
	eval "$(atuin init bash)"
fi
