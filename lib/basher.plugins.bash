# shellcheck shell=bash

cite about-plugin
about-plugin 'Initializes basher, the shell package manager'

if [[ -x "$HOME/.basher/bin/basher" ]]; then
	pathmunge "$HOME/.basher/bin"
	# Ask for the init code of the shell that is running (bash or zsh)
	_basher_init_shell="${ZSH_VERSION:+zsh}"
	eval "$(basher init - "${_basher_init_shell:-bash}")"
	unset _basher_init_shell
else
	_log_warning 'basher not found'
	return 0
fi
