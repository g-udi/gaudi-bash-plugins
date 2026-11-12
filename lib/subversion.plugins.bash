# shellcheck shell=bash

cite about-plugin
about-plugin 'SVN helper functions'

rm_svn () {
  about 'Remove ".svn" files from directory'
  group 'subversion'

  if [[ -z "$1" ]]; then
      echo "Usage: rm_svn <directory>" >&2
      return 1
  fi
  find "$1" -name .svn -print0 | xargs -0 rm -rf
}

svn_add () {
    about 'Add to svn repo'
    group 'subversion'

    # One unversioned path per line, handed over NUL-separated so that names
    # with spaces stay whole
    svn status | sed -n 's/^? *//p' | tr '\n' '\0' | xargs -0 svn add
}
