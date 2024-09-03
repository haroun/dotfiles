# TODO https://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
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
# The time the shell waits, in hundredths of seconds, for another key to be pressed when reading bound multi-character sequences.
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
# opt-tools
if [[ -d "/opt/opt-tools/bin" ]]; then
  PATH="${PATH}:/opt/ops-tools/bin"
fi
# stagecoach
if [[ -d "/opt/stagecoach/bin" ]]; then
  PATH="${PATH}:/opt/stagecoach/bin"
fi
