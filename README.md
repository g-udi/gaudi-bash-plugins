# gaudi-bash plugins

This repo contains a submodule for [gaudi-bash](https://github.com/g-udi/gaudi-bash) with all the plugins it loads.

## Host contract

The files in `lib/` are shared, byte for byte, by [gaudi-bash](https://github.com/g-udi/gaudi-bash) (bash 4.3 or later) and [gaudi-shell](https://github.com/g-udi/gaudi-shell) (bash 3.2 or later, and zsh). A file must therefore not name either framework (no `GAUDI_BASH*` or `GAUDI_SHELL*` variable, no `gbash` or `gshell` command) and may only rely on what both frameworks provide:

| Name | Meaning |
| --- | --- |
| `cite`, `about-alias`, `about-plugin`, `about-completion`, `about`, `group`, `param`, `example`, `priority` | metadata read by `show`, `search`, `help` and `enable` |
| `_command_exists <name>` | true when `<name>` is anything the shell can run (function, alias, builtin or program); logs an error otherwise |
| `_binary_exists <name>` | true only when `<name>` is a program on `PATH`; a function or an alias does not count |
| `_homebrew-check` | true when Homebrew is installed; sets `GAUDI_HOST_HOMEBREW_PREFIX` |
| `pathmunge <dir> [after]` | add a directory to `PATH` once |
| `_log_debug`, `_log_warning`, `_log_error` | logging |
| `GAUDI_HOST_NAME` | the framework's name (`gaudi-bash` or `gaudi-shell`), for messages and cache folders |
| `GAUDI_HOST_COMMAND` | the command its users type (`gbash` or `gshell`) |
| `GAUDI_HOST_HOME` | its install directory; `components/enabled` and `components/custom` live under it |
| `GAUDI_HOST_SED_I_PARAMETERS` | array with the arguments that make `sed` edit in place on this OS |
| `GAUDI_HOST_HOMEBREW_PREFIX` | the Homebrew prefix, empty until `_homebrew-check` or the brew plugin has found it |
| `_gaudi_host_setting <NAME>` | prints the user's setting `<NAME>` (for example `HTTP_PROXY`): `GAUDI_<NAME>`, otherwise the framework's own `GAUDI_BASH_<NAME>` or `GAUDI_SHELL_<NAME>` |

Each framework defines these once, in its `lib/helpers/utils.bash`. Keep every file loadable by bash 3.2 (no `mapfile`, `declare -A`, `${var,,}`, `&>>` or negative array indexes) unless it only makes sense in bash 4, and guard anything that cannot work in zsh with `[[ -n "${ZSH_VERSION:-}" ]]`.

## Checklist

- [ ] Make sure to have `# shellcheck shell=bash` at the top of every file and have an empty newline after
- [ ] Make sure to have the `cite about-plugin`
- [ ] Make sure to fill in a description of the plugin in the `about-plugin`

 ```bash
# shellcheck shell=bash

cite about-plugin
about-plugin 'Autojump configuration [ref: https://github.com/wting/autojump]'
 ```

## Plugins

- [**alias-completion**](/lib/alias-completion.plugins.bash): Automatic completion of aliases
- [**atuin**](/lib/atuin.plugins.bash): Load Atuin! The magical shell history via ble.sh
- [**autojump**](/lib/autojump.plugins.bash): Autojump configuration
- [**aws**](/lib/aws.plugins.bash): AWS helper functions
- [**base**](/lib/base.plugins.bash): Miscellaneous base tools
- [**basher**](/lib/basher.plugins.bash): Initializes basher, the shell package manager
- [**blesh**](/lib/blesh.plugins.bash): load ble.sh, the Bash line editor!
- [**brew**](/lib/brew.plugins.bash): Load Homebrew shell environment and user-local binaries
- [**bun**](/lib/bun.plugins.bash): Configure Bun install directory and add Bun to PATH
- [**cargo**](/lib/cargo.plugins.bash): Configure Cargo install directory and add Cargo binaries to PATH
- [**chruby**](/lib/chruby.plugins.bash): Load chruby (from the Homebrew prefix, `/usr/local` or `/usr`)
- [**cht-sh**](/lib/cht-sh.plugins.bash): Simplify `curl cht.sh/<query>` to `cht.sh <query>`
- [**cmd-returned-notify**](/lib/cmd-returned-notify.plugins.bash): Alert (BEL) when a command takes longer than a threshold to complete
- [**compress**](/lib/compress.plugins.bash): Compression tools
- [**direnv**](/lib/direnv.plugins.bash): Load [direnv](https://direnv.net/)
- [**dirs**](/lib/dirs.plugins.bash): Directory stack navigation
- [**docker-compose**](/lib/docker-compose.plugins.bash): Helper functions for using docker-compose
- [**docker**](/lib/docker.plugins.bash): Helpers to more easily work with Docker
- [**edit-mode-emacs**](/lib/edit-mode-emacs.plugins.bash): Enable emacs editing mode
- [**edit-mode-vi**](/lib/edit-mode-vi.plugins.bash): Enable vi editing mode
- [**encode**](/lib/encode.plugins.bash): Encoding and decoding functions
- [**explain**](/lib/explain.plugins.bash): mankier.com explain function to explain other commands
- [**extract**](/lib/extract.plugins.bash): Universal archive extractor
- [**fasd**](/lib/fasd.plugins.bash): load fasd, if you are using it
- [**fzf**](/lib/fzf.plugins.bash): Load fzf, a Command-line fuzzy finder written in Go
- [**gif**](/lib/gif.plugins.bash): Video to gif, gif to WebM helper functions
- [**git-subrepo**](/lib/git-subrepo.plugins.bash): Loads Git Submodule Alternative via git-subrepo and initialize completions
- [**git**](/lib/git.plugins.bash): Git helper functions
- [**gitstatus**](/lib/gitstatus.plugins.bash): Speeds up your life by using gitstatus for [git status](https://github.com/romkatv/gitstatus) calculations
- [**go**](/lib/go.plugins.bash): Go environment variables & path configuration
- [**goenv**](/lib/goenv.plugins.bash): Load Go version management via goenv
- [**gradle**](/lib/gradle.plugins.bash): Add a gw command to use gradle wrapper if present, else use system gradle
- [**hg**](/lib/hg.plugins.bash): Mercurial helper functions
- [**history**](/lib/history.plugins.bash): history manipulation
- [**hub**](/lib/hub.plugins.bash): Load GitHub support to git on the command-line via hub
- [**java**](/lib/java.plugins.bash): Java and JAR helper functions
- [**jekyll**](/lib/jekyll.plugins.bash): Manage your jekyll site
- [**jenv**](/lib/jenv.plugins.bash): Manage your Java environment via jenv
- [**jgitflow**](/lib/jgitflow.plugins.bash): Maven jgitflow build helpers (the branch pushed on finish is `JGITFLOW_MASTER_BRANCH`, `master` by default)
- [**json**](/lib/json.plugins.bash): Syntax-highlight JSON strings or files
- [**jump**](/lib/jump.plugins.bash): Initialize [jump](https://github.com/gsamokovarov/jump). Add `export JUMP_OPTS=("--bind=z")` to change keybinding
- [**latex**](/lib/latex.plugins.bash): Add mactex to the path if its present
- [**man**](/lib/man.plugins.bash): Colorize man pages for better readability
- [**nginx**](/lib/nginx.plugins.bash): Manage your nginx service
- [**node**](/lib/node.plugins.bash): Node.js helper functions
- [**nvm**](/lib/nvm.plugins.bash): Node version manager configuration (lazy-loaded for fast startup)
- [**osx**](/lib/osx.plugins.bash): OSX specific functions
- [**percol**](/lib/percol.plugins.bash): Search & Select history with percol
- [**pipx**](/lib/pipx.plugins.bash): Install and Run Python Applications in Isolated Environments
- [**postgres**](/lib/postgres.plugins.bash): Postgres helper functions
- [**powerline**](/lib/powerline.plugins.bash): Enables powerline daemon
- [**proxy**](/lib/proxy.plugins.bash): Proxy Tools
- [**pyenv**](/lib/pyenv.plugins.bash): Python version management via pyenv (lazy-loaded for fast startup)
- [**pygmentize**](/lib/pygmentize.plugins.bash): pygmentize instead of cat to terminal if possible
- [**python**](/lib/python.plugins.bash): Python helpers: `shttp` (http.server in the current directory) and `pyedit`
- [**rails**](/lib/rails.plugins.bash): Helper functions for Ruby on Rails
- [**rbenv**](/lib/rbenv.plugins.bash): Ruby Version Manager via rbenv
- [**ruby**](/lib/ruby.plugins.bash): Ruby and rubygems specific functions and settings
- [**rvm**](/lib/rvm.plugins.bash): Ruby Version Manager (RVM)
- [**sdkman**](/lib/sdkman.plugins.bash): Load Software Development Kit Manager
- [**server**](/lib/server.plugins.bash): Create Simple HTTP Server
- [**ssh**](/lib/ssh.plugins.bash): SSH helper functions
- [**sshagent**](/lib/sshagent.plugins.bash): SSH Agent helper functions
- [**subversion**](/lib/subversion.plugins.bash): SVN helper functions
- [**sudo**](/lib/sudo.plugins.bash): Toggle sudo with ESC-ESC
- [**thefuck**](/lib/thefuck.plugins.bash): Initialization for fuck
- [**tmux**](/lib/tmux.plugins.bash): Make sure that tmux is launched in 256 color mode
- [**tmuxinator**](/lib/tmuxinator.plugins.bash): Sources tmuxinator script if available
- [**url**](/lib/url.plugins.bash): Basic url handling and manipulation functions
- [**xterm**](/lib/xterm.plugins.bash): Automatically set your xterm title with host and location info
- [**zoxide**](/lib/zoxide.plugins.bash): Zoxide is a smarter cd command for your shell.
