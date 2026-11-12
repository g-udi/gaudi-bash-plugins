# shellcheck shell=bash

cite about-plugin
about-plugin 'Python helpers: shttp (http.server in the current directory) and pyedit'

# command -v: a function counts too (the pyenv plugin's lazy-load stub), and a
# missing python3 is not an error when python is there
if command -v python3 > /dev/null 2>&1; then
	alias shttp='python3 -m http.server'
elif command -v python > /dev/null 2>&1; then
	alias shttp='python -m http.server'
else
	_log_warning "Unable to load 'plugin/python' due to being unable to find a working 'python'"
	return 1
fi

function pyedit() {
	about 'opens python module in your EDITOR'
	param '1: python module to open'
	example '$ pyedit requests'
	group 'python'

	local xpyc xpydir python_bin=python3
	hash python3 2> /dev/null || python_bin=python

	# The module name is passed as an argument, never pasted into the Python source
	xpyc="$("$python_bin" -c "import os, sys; sys.stderr = open(os.devnull, 'w'); module = __import__(sys.argv[1]); sys.stdout.write(module.__file__)" "$1")"

	if [[ "$xpyc" == "" ]]; then
		echo "Python module $1 not found"
		return 1
	elif [[ "$xpyc" == *__init__.py* ]]; then
		xpydir="${xpyc%/*}"
	else
		xpydir="${xpyc%.*}.py"
	fi

	# eval: the editor may hold arguments ("code -w"), and zsh does not split words
	local editor="${VISUAL:-${EDITOR:-${ALTERNATE_EDITOR:-nano}}}"
	echo "$editor $xpydir"
	eval "$editor \"\$xpydir\""
}
