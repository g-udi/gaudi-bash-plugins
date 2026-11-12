# shellcheck shell=bash
# shellcheck disable=1090

cite about-plugin
about-plugin 'Load ble.sh, the Bash line editor!'

# Bash only: ble.sh is a line editor for bash
[[ -n "${BASH_VERSION:-}" ]] || return 0

if [[ ${BLE_VERSION-} ]]; then
	_log_warning "ble.sh is already loaded!"
	return
fi

_gaudi_ble_path=${XDG_DATA_HOME:-$HOME/.local/share}/blesh/ble.sh
if [[ -f $_gaudi_ble_path ]]; then
	source "$_gaudi_ble_path" --attach=prompt
else
	_log_error "Could not find ble.sh in $_gaudi_ble_path, please install using the following command: git clone https://github.com/akinomyoga/ble.sh && make -C ble.sh install"
fi
unset _gaudi_ble_path
