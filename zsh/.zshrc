# GPG, https://gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html
export LANG=en
export PATH="/usr/local/opt/dirmngr/bin:/usr/local/opt/gpg-agent/bin:/usr/local/sbin:$PATH"
GPG_TTY=$(tty)
export GPG_TTY

# Save history
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory" # The path to the history file.
HISTSIZE=10000 # The maximum number of events to save in the internal history.
SAVEHIST=10000 # The maximum number of events to save in the history file.

# Vi mode
bindkey -v
export KEYTIMEOUT=1 # kill lag for mode change

# Prompt
autoload -U promptinit; promptinit
prompt pure

# Vim prompt
VIM_PROMPT="❯"
PROMPT='%(?.%F{magenta}.%F{red})${VIM_PROMPT}%f '
prompt_pure_update_vim_prompt() {
  zle || {
    print "error: pure_update_vim_prompt must be called when zle is active"
    return 1
  }
  VIM_PROMPT=${${KEYMAP/vicmd/❮}/(main|viins)/❯}
  # [[ ! -o zle ]] && print 'zle\n'
  # setopt NO_SINGLE_LINE_ZLE
  [[ ! -z $BUFFER ]] && zle .reset-prompt
}
function zle-line-init zle-keymap-select {
  prompt_pure_update_vim_prompt
}
prompt_pure_post_vim_prompt() {
  echo ''
}
function zle-line-finish {
  prompt_pure_post_vim_prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish

# Completions
fpath=(/usr/local/share/zsh-completions $fpath)
autoload -Uz compinit; compinit

# Syntax-highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History substring search (require to be set after syntax highlighting according to documentation)
source /usr/local/opt/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[f' vi-forward-word

# Autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Aliases
alias ls='ls -F -G' # Color output for ls
alias ll='ls -lah' # Lists human readable sizes, hidden files.
alias grep='grep --color=auto' # Mark up the matching text with color
alias ip='dig +short myip.opendns.com @resolver1.opendns.com' # ip address
alias DELETE='lwp-request -m "DELETE"' # Send a DELETE request
alias POST='lwp-request -m "POST"' # Send a POST request
alias PUT='lwp-request -m "PUT"' # Send a PUT request
