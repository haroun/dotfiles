export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="/usr/local/sbin:$PATH"
# GPG, https://gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
GPG_TTY=$(tty)
export GPG_TTY
export TERM=xterm-256color
export ZMODULES_DIR="$HOME/repositories/dotfiles/zsh/modules"
# nvm
export NVM_DIR="$HOME/.nvm"
