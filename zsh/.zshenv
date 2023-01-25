export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# export PATH="/usr/local/sbin:$NVM_BIN:$PATH"
# GPG, https://gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
GPG_TTY=$(tty)
export GPG_TTY
export TERM=xterm-256color
# vi
export KEYTIMEOUT=1 # kill lag for mode change
# nvm
export NVM_DIR="$HOME/.nvm"
# Ripgrep + FZF
#RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
#INITIAL_QUERY=""
#FZF_DEFAULT_COMMAND="$RG_PREFIX '$INITIAL_QUERY'" \
#  fzf --bind "change:reload:$RG_PREFIX {q} || true" \
#      --ansi --phony --query "$INITIAL_QUERY"
#FZF_DEFAULT_COMMAND="rg --column --line-number --no-heading --color=always --smart-case "
# deno
if [[ -a "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi
# opt-tools
if [[ -d "/opt/opt-tools/bin" ]]; then
  export PATH="/opt/ops-tools/bin:$PATH"
fi
# stagecoach
if [[ -d "/opt/stagecoach/bin" ]]; then
  export PATH="/opt/stagecoach/bin:$PATH"
fi
