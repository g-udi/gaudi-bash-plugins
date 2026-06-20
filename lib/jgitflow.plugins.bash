# shellcheck shell=bash

cite about-plugin
about-plugin 'Maven jgitflow build helpers'

_jgitflow_mvn () {
  local goal="$1"
  local -a args=()

  if [[ -n "${JGITFLOW_MVN_ARGUMENTS:-}" ]]; then
    read -r -a args <<< "${JGITFLOW_MVN_ARGUMENTS}"
  fi

  mvn "$goal" "${args[@]}"
}

hotfix-start () {
  about 'Helper function for starting a new hotfix'
  group 'gitflow'

  _jgitflow_mvn jgitflow:hotfix-start
}

hotfix-finish () {
  about 'Helper function for finishing a hotfix'
  group 'gitflow'

  mvn jgitflow:hotfix-finish -Darguments="${JGITFLOW_MVN_ARGUMENTS}" && git push && git push origin master && git push --tags
}

feature-start () {
  about 'Helper function for starting a new feature'
  group 'gitflow'

  _jgitflow_mvn jgitflow:feature-start
}

feature-finish () {
  about 'Helper function for finishing a feature'
  group 'gitflow'

  _jgitflow_mvn jgitflow:feature-finish

  echo -e 'REMEMBER TO CREATE A NEW RELEASE TO DEPLOY THIS FEATURE'
}

release-start () {
  about 'Helper function for starting a new release'
  group 'gitflow'

  _jgitflow_mvn jgitflow:release-start
}

release-finish () {
  about 'Helper function for finishing a release'
  group 'gitflow'

  mvn jgitflow:release-finish -Darguments="${JGITFLOW_MVN_ARGUMENTS}" && git push && git push origin master && git push --tags
}
