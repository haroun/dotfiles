export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export PATH="/usr/local/sbin:$PATH"
# GPG, https://gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
GPG_TTY=$(tty)
export GPG_TTY
export TERM=xterm-256color
# vi
export KEYTIMEOUT=1 # kill lag for mode change
# nvm
export NVM_DIR="$HOME/.nvm"
# Ripgrep + FZF
export INITIAL_QUERY=""
export RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
export FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY' fzf --bind 'change:reload:$RG_PREFIX {q} || true' --ansi --phony --query '$INITIAL_QUERY' --height=50% --layout=reverse"
