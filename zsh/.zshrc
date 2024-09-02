# Save history
HISTFILE="${ZDOTDIR:-$HOME}/.zhistory" # The path to the history file.
HISTSIZE=10000 # The maximum number of events to save in the internal history.
SAVEHIST=${HISTSIZE} # The maximum number of events to save in the history file.
HISTDUP=erase # Erase duplicates from history file
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Vi mode
bindkey -v

# Prompt
autoload -Uz vcs_info
precmd () { vcs_info }
autoload -Uz promptinit && promptinit
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%b %u%c '
zstyle ':vcs_info:git:*' actionformats '%b [%a|%m] '
zstyle ':vcs_info:git:*' check-for-changes true
# zstyle ':vcs_info:git:*' check-for-staged-changes true # faster than check-for-changes
zstyle ':vcs_info:git:*' stagedstr '%F{green}·%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}˟%f'
zstyle ':vcs_info:git:*' patch-format '%p (%n/%a)'
setopt PROMPT_SUBST
function zle-line-init zle-keymap-select {
  VIM_PROMPT=${${KEYMAP/vicmd/❮}/(main|viins)/❯}
  zle reset-prompt
}
function zle-line-finish {
  echo ''
}
zle -N zle-line-init
zle -N zle-keymap-select
zle -N zle-line-finish
# TODO: elapsed time, sudo, pid, status code
PS1='%F{cyan}%B${PWD/#$HOME/~}%b%f %F{gray}${vcs_info_msg_0_}%f%(?.%F{magenta}.%F{red})${VIM_PROMPT}%f '

# Autosuggestions
source ${HOME}/.zshmodules/zsh-users/zsh-autosuggestions/zsh-autosuggestions.zsh

# Completions
fpath=(${HOME}/.zshmodules/zsh-users/zsh-completions $fpath)
autoload -Uz compinit && compinit

# Syntax-highlighting
source ${HOME}/.zshmodules/zsh-users/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# History substring search (require to be set after syntax highlighting according to documentation)
source ${HOME}/.zshmodules/zsh-users/zsh-history-substring-search/zsh-history-substring-search.zsh

# Completion styling
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
# zstyle ':completion:*:*:*:default' menu yes select search
zstyle ':completion:*' menu select

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
alias rm='rm -i'
alias c='clear'

# fzf
# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# dircolors
test -r ~/.dir_colors && eval $(dircolors ~/.dir_colors)

# Key bindings
bindkey '^y' autosuggest-accept # Ctrl+y to accept suggestion
bindkey '^ ' autosuggest-accept # Ctrl+Space to accept suggestion
bindkey '^H' backward-delete-char # Ctrl+H to Backspace
bindkey '^p' history-search-backward # Ctrl+p to search backward
bindkey '^n' history-search-forward # Ctrl+n to search forward
bindkey '^[[A' history-substring-search-up # Up arrow key
bindkey '^[[B' history-substring-search-down # Down arrow key
bindkey '^[f' vi-forward-word # Right arrow key

# nvm
[ -s "${NVM_DIR}/nvm.sh" ] && . "${NVM_DIR}/nvm.sh"  # This loads nvm
[[ -r "${NVM_DIR}/bash_completion" ]] && \. "${NVM_DIR}/bash_completion" # This loads nvm bash_completion

# ripgrep > fzf > nvim [QUERY]
# https://junegunn.github.io/fzf/tips/ripgrep-integration/
rfn() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)

# fzf log
# https://junegunn.github.io/fzf/tips/browsing-log-streams/
fl() (
  fzf --tail 100000 --tac --no-sort --exact --wrap
)
