# shellcheck shell=bash

cite about-plugin
about-plugin 'Install and Run Python Applications in Isolated Environments'

if command -v pipx &> /dev/null; then
  pipx ensurepath
fi
