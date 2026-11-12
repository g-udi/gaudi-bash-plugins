# shellcheck shell=bash

cite about-plugin
about-plugin 'Create Simple HTTP Server'

# Serves the current directory on port 8000 (same as shttp from the python plugin).
# https is also a real tool (HTTPie): alias it only when no such binary is installed
_binary_exists https || alias https='python3 -m http.server'
