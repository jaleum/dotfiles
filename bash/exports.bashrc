# exports
export PATH="${HOME}/bin":$PATH
export VISUAL='vim'  # default GUI editor
export EDITOR="$VISUAL"  # default command line editor
export IGNOREEOF=2  # prevent terminal window from closing on ctrl-d 2 times

# history improvements
setopt HIST_IGNORE_DUPS  # don't save immediate duplicates
# export HISTCONTROL=ignoredups  # bash version of above

export HISTSIZE=100000
export HISTIGNORE='ls:history'  # don't include certain commands in history
setopt EXTENDED_HISTORY  # include timestamps

setopt INC_APPEND_HISTORY  # append to history rather than rewrite
# export PROMPT_COMMAND='history -a'  # bash version of above
# shopt -s histappend  # bash version of above

# python
export WORKSPACE="$HOME/workspace"
export PYTHON_VENV="$WORKSPACE/python-venv"
export PYTHON_VENV_NAME="my_env"

