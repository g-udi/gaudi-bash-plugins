# gaudi-bash plugins

This repo contains a submodule for [gaudi-bash](https://github.com/g-udi/gaudi-bash) with all the plugins it loads.

## Plugins

- [**alias-completion**](/lib/alias-completion.plugins.bash): Automatic completion of aliases
- [**autojump**](/lib/autojump.plugins.bash): Autojump configuration
- [**aws**](/lib/aws.plugins.bash): AWS helper functions
- [**base**](/lib/base.plugins.bash): Miscellaneous tools
- [**basher**](/lib/basher.plugins.bash): Initializes basher, the shell package manager
- [**blesh**](/lib/blesh.plugins.bash): load ble.sh, the Bash line editor!
- [**boot2docker**](/lib/boot2docker.plugins.bash): Helpers to get Docker setup correctly for boot2docker
- [**browser**](/lib/browser.plugins.bash): render commandline output in your browser (based on https://gist.github.com/318247)
- [**cht-sh**](/lib/cht-sh.plugins.bash): Simplify `curl cht.sh/<query>` to `cht.sh <query>`
- [**compress**](/lib/compress.plugins.bash): Compression tools
- [**direnv**](/lib/direnv.plugins.bash): Load [direnv](https://direnv.net/)
- [**dirs**](/lib/dirs.plugins.bash): Directory stack navigation
- [**docker-compose**](/lib/docker-compose.plugins.bash): Helper functions for using docker-compose
- [**docker**](/lib/docker.plugins.bash): Helpers to more easily work with Docker
- [**edit-mode-emacs**](/lib/edit-mode-emacs.plugins.bash): Enable emacs editing mode
- [**edit-mode-vi**](/lib/edit-mode-vi.plugins.bash): Enable vi editing mode
- [**encode**](/lib/encode.plugins.bash): Encoding and decoding functions
- [**explain**](/lib/explain.plugins.bash): mankier.com explain function to explain other commands
- [**extract**](/lib/extract.plugins.bash): Extractor helper functions for various archive types
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
- [**jgitflow**](/lib/jgitflow.plugins.bash): Maven jgitflow build helpers
- [**json**](/lib/json.plugins.bash): Syntax-highlight JSON strings or files
- [**jump**](/lib/jump.plugins.bash): Initialize [jump](https://github.com/gsamokovarov/jump). Add `export JUMP_OPTS=("--bind=z")` to change keybinding
- [**latex**](/lib/latex.plugins.bash): Add mactex to the path if its present
- [**man**](/lib/man.plugins.bash): Colorize man pages for better readability
- [**nginx**](/lib/nginx.plugins.bash): Manage your nginx service
- [**node**](/lib/node.plugins.bash): Node.js helper functions
- [**nodenv**](/lib/nodenv.plugins.bash): Load nodenv | Node.js virtual environment builder
- [**nvm**](/lib/nvm.plugins.bash): Node version manager configuration
- [**osx**](/lib/osx.plugins.bash): OSX specific functions
- [**pack**](/lib/pack.plugins.bash): CNB pack cli aliases
- [**percol**](/lib/percol.plugins.bash): Search & Select history with percol
- [**pipx**](/lib/pipx.plugins.bash): Install and Run Python Applications in Isolated Environments
- [**postgres**](/lib/postgres.plugins.bash): Postgres helper functions
- [**powerline**](/lib/powerline.plugins.bash): Enables powerline daemon
- [**projects**](/lib/projects.plugins.bash): Quickly navigate configured paths with `pj` and `pjo`. example: `export PROJECT_PATHS=~/projects:~/work/projects`
- [**proxy**](/lib/proxy.plugins.bash): Proxy Tools
- [**pyenv**](/lib/pyenv.plugins.bash): Python version management via pyenv
- [**pygmentize**](/lib/pygmentize.plugins.bash):.plugins.bash pygmentize instead of cat to terminal if possible
- [**rails**](/lib/rails.plugins.bash): Helper functions for Ruby on Rails
- [**rbenv**](/lib/rbenv.plugins.bash): Ruby Version Manager via rbenv
- [**ruby**](/lib/ruby.plugins.bash): Ruby and rubygems specific functions and settings
- [**rvm**](/lib/rvm.plugins.bash): Ruby Version Manager (RVM)
- [**sdkman**](/lib/sdkman.plugins.bash): Load Software Development Kit Manager
- [**server**](/lib/server.plugins.bash): Create Simple HTTP Server
- [**ssh**](/lib/ssh.plugins.bash): SSH helper functions
- [**sshagent**](/lib/sshagent.plugins.bash): SSH Agent helper functions
- [**subversion**](/lib/subversion.plugins.bash): SVN helper functions
- [**thefuck**](/lib/thefuck.plugins.bash): Initialization for fuck
- [**tmux**](/lib/tmux.plugins.bash): Make sure that tmux is launched in 256 color mode
- [**tmuxinator**](/lib/tmuxinator.plugins.bash): Sources tmuxinator script if available
- [**xterm**](/lib/xterm.plugins.bash): Automatically set your xterm title with host and location info
- [**z_autoenv**](/lib/z_autoenv.plugins.bash): Source into environment when cding to directories
- [**zoxide**](/lib/zoxide.plugins.bash): Zoxide is a smarter cd command for your shell.