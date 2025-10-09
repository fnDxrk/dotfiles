# Fix percent (%) character before prompt in zsh
if [[ "$TERM_PROGRAM" == "WezTerm" ]]; then
  sleep 0.1
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi 

# Environment
HISTFILE="$ZDOTDIR/.zhistory"
HISTSIZE=100000
SAVEHIST=100000
export WORDCHARS=${WORDCHARS//\/}

# History options
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_FIND_NO_DUPS
setopt GLOB_COMPLETE
#setopt globdots


# Completion settings
autoload -Uz compinit; compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Vim mode
# bindkey -v
# export KEYTIMEOUT=1
# zmodload zsh/complist
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey '^W' backward-kill-word

# Bindkey
# Backspace - delete char before cursor
bindkey '^?' backward-delete-char

# Ctrl+Backspace - delete word before cursor
bindkey '^H' backward-kill-word
# Alt+Backspace - delete word before cursor
bindkey '^[^?' backward-kill-word
# Ctrk+W - delete word before cursor
bindkey '^W' backward-kill-word

# Home - move cursor to start of line
bindkey '^[[H' beginning-of-line
# End - move cursor to end of line
bindkey '^[[F' end-of-line
# Ctrl+Home - move cursor to start of line
bindkey '^[[1;5H' beginning-of-line
# Ctrl+End - move cursor to end of line
bindkey '^[[1;5F' end-of-line

# Ctrl+Left - move cursor to previous word
bindkey '^[[1;5D' backward-word
# Ctrl+Right - move cursor to next word
bindkey '^[[1;5C' forward-word

# Alt+Left - move cursor to previous word
bindkey '^[[1;3D' backward-word
# Alt+Right - move cursor to next word
bindkey '^[[1;3C' forward-word

# Up/Down - search command history
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# Source
source $ZDOTDIR/.alias

# Antidote
source /usr/share/zsh-antidote/antidote.zsh
antidote load

# Select menu autocomplete
zmodload zsh/complist
zstyle ':completion:*' menu select

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
