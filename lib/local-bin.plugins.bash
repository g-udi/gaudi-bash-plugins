# shellcheck shell=bash

cite about-plugin
about-plugin 'Add user-local binaries to PATH'

pathmunge "${GAUDI_LOCAL_BIN:-$HOME/.local/bin}"
