# Save history
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory" # The path to the history file.
HISTSIZE=10000 # The maximum number of events to save in the internal history.
SAVEHIST=10000 # The maximum number of events to save in the history file.

# Vi mode
bindkey -v

# Prompt
# https://github.com/Parth/dotfiles/blob/master/zsh/prompt.sh
autoload -U promptinit; promptinit
set-prompt() {
  # Vim prompt
  VIM_PROMPT=${${KEYMAP/vicmd/❮}/(main|viins)/❯}
  # arrow
  PROMPT="%(?.%F{magenta}.%F{red})${VIM_PROMPT}%f "
  # [
  PROMPT+="%F{white}[%f"
  # path
  PROMPT+="%F{cyan}%B${PWD/#$HOME/~}%b%f"
  # status code
  PROMPT+="%(?.., %F{red}%?%f)"
  # git
  if git rev-parse --is-inside-work-tree 2> /dev/null | grep -q 'true' ; then
    PROMPT+=', '
    PROMPT+="%F{blue}$(git rev-parse --abbrev-ref HEAD 2> /dev/null)%f"
    if [ $(git status --short | wc -l) -gt 0 ]; then
      PROMPT+="%F{red}+$(git status --short | wc -l | awk '{$1=$1};1')%f"
    fi
  fi
  # timer
  if [[ $_elapsed[-1] -ne 0 ]]; then
    PROMPT+=', '
    PROMPT+="%F{magenta}$_elapsed[-1]s%f"
  fi
  # PID
  if [[ $! -ne 0 ]]; then
    PROMPT+=', '
    PROMPT+="%F{yellow}PID:$!%f"
  fi
  # sudo
  CAN_I_RUN_SUDO=$(sudo -n uptime 2>&1 | grep 'load' | wc -l)
  if [ ${CAN_I_RUN_SUDO} -gt 0 ]
  then
    PROMPT+=', '
    PROMPT+="%F{red}%Bsudo%b%f"
  fi
  # ]
  PROMPT+="%F{white}]:%f "
}
preexec () {
  (( ${#_elapsed[@]} > 1000 )) && _elapsed=(${_elapsed[@]: -1000})
    _start=$SECONDS
}
precmd () {
  (( _start >= 0 )) && _elapsed+=($(( SECONDS-_start )))
    _start=-1
  set-prompt
}
function zle-line-init zle-keymap-select {
  set-prompt
  zle reset-prompt
}
function zle-line-finish {
  echo ''
}
zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish

# Completions
fpath=(${HOME}/.zshmodules/zsh-users/zsh-completions $fpath)
autoload -Uz compinit; compinit

# Syntax-highlighting
source ${HOME}/.zshmodules/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History substring search (require to be set after syntax highlighting according to documentation)
source ${HOME}/.zshmodules/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[f' vi-forward-word

# Autosuggestions
source ${HOME}/.zshmodules/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh

# Aliases
alias ls='ls -F -G --color=auto' # Color output for ls
alias ll='ls -lah' # Lists human readable sizes, hidden files.
alias grep='grep --color=auto' # Mark up the matching text with color
alias ip='dig +short myip.opendns.com @resolver1.opendns.com' # ip address
alias GET='lwp-request -m "GET"' # Send a GET request
alias DELETE='lwp-request -m "DELETE"' # Send a DELETE request
alias POST='lwp-request -m "POST"' # Send a POST request
alias PUT='lwp-request -m "PUT"' # Send a PUT request
alias PATCH='lwp-request -m "PATCH"' # Send a PATCH request
alias HEAD='lwp-request -m "HEAD"' # Send a HEAD request

# nvm
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"  # This loads nvm
[ -s "${NVM_DIR}/bash_completion" ] && . "${NVM_DIR}/bash_completion"  # This loads nvm bash_completion

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# tern
# Also if you are using add loadEagerly - * many files * - this to your .bashrc or .zshrc, this will allow you load all files you need when ternjs is started.
ulimit -n 2048
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# dircolors
test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)
