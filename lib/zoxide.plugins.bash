# shellcheck shell=bash

cite about-plugin
about-plugin 'Zoxide is a smarter cd command for your shell'

if _binary_exists zoxide; then
	# Ask for the init code of the shell that is running (bash or zsh)
	_gaudi_zoxide_shell="${ZSH_VERSION:+zsh}"
	eval "$(zoxide init "${_gaudi_zoxide_shell:-bash}")"
	unset _gaudi_zoxide_shell
else
	_log_error 'zoxide not found, please install it from https://github.com/ajeetdsouza/zoxide'
fi
