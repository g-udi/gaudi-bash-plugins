# shellcheck shell=bash

cite about-plugin
about-plugin 'Java and JAR helper functions'

java-link-openjdk () {
  about 'Link Homebrew OpenJDK into the macOS JavaVirtualMachines directory'
  group 'java'

  # The Homebrew prefix differs per machine (/opt/homebrew, /usr/local)
  local brew_prefix="${GAUDI_HOST_HOMEBREW_PREFIX:-${HOMEBREW_PREFIX:-/opt/homebrew}}"
  local source_jdk="${1:-${brew_prefix}/opt/openjdk/libexec/openjdk.jdk}"
  local target_jdk="/Library/Java/JavaVirtualMachines/openjdk.jdk"

  if [[ ! -d "$source_jdk" ]]; then
    printf 'OpenJDK not found at %s\n' "$source_jdk" >&2
    return 1
  fi

  sudo ln -sfn "$source_jdk" "$target_jdk"
}
