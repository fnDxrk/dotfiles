typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

pfetch

setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS

autoload -U compinit; compinit

_comp_options+=(globdots)

source /usr/share/zsh-antidote/antidote.zsh
source $ZDOTDIR/key-bindings.zsh 
source $ZDOTDIR/history.zsh
source $ZDOTDIR/completion.zsh

antidote load

[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
