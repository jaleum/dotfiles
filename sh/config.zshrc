setopt HIST_IGNORE_DUPS  # don't save immediate duplicates
# export HISTCONTROL=ignoredups  # bash version of above

setopt EXTENDED_HISTORY  # include timestamps

setopt INC_APPEND_HISTORY  # append to history rather than rewrite
# export PROMPT_COMMAND='history -a'  # two lines are bash version of above
# shopt -s histappend

# zsh completion more like bash
setopt BEEP NO_AUTOLIST BASH_AUTOLIST NO_MENUCOMPLETE no_always_last_prompt noautomenu
setopt globdots  # allow dotfiles to be suggested without the leading dot
