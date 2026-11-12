# shellcheck shell=bash

cite about-plugin
about-plugin 'pygmentize instead of cat to terminal if possible'

if command -v pygmentize > /dev/null 2>&1 ; then
  # get the full paths to binaries
  _gaudi_pygmentize_cat=$(command -v cat)
  _gaudi_pygmentize_less=$(command -v less)
  # styles: the settings CCAT_STYLE / CLESS_STYLE; the legacy BASH_IT_CCAT_STYLE /
  # BASH_IT_CLESS_STYLE are still read and win when set
  _gaudi_pygmentize_style="$(_gaudi_host_setting CCAT_STYLE)"
  _gaudi_pygmentize_ccat_style="${BASH_IT_CCAT_STYLE:-${_gaudi_pygmentize_style:-default}}"
  _gaudi_pygmentize_style="$(_gaudi_host_setting CLESS_STYLE)"
  _gaudi_pygmentize_cless_style="${BASH_IT_CLESS_STYLE:-${_gaudi_pygmentize_style:-default}}"
  unset _gaudi_pygmentize_style

  # pigmentize cat and less outputs - call them ccat and cless to avoid that
  # especially cat'ed output in scripts gets mangled with pygemtized meta characters
  ccat()
  {
      about 'runs either pygmentize or cat on each file passed in'
      param '*: files to concatenate (as normally passed to cat)'
      example 'ccat mysite/manage.py dir/text-file.txt'
      group 'pygmentize'

      local file
      for file;
      do
          pygmentize -f 256 -O style="$_gaudi_pygmentize_ccat_style" -g "$file" 2>/dev/null || "$_gaudi_pygmentize_cat" "$file";
      done
  }

  cless()
  {
      about 'it pigments the file passed in and passes it to less for pagination'
      param "\$1: the file to paginate with less"
      example 'cless mysite/manage.py'
      group 'pygmentize'
      pygmentize -f 256 -O style="$_gaudi_pygmentize_cless_style" -g "$@" | "$_gaudi_pygmentize_less" -R
  }
fi
