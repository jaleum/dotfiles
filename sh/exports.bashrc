# exports
export PATH="${HOME}/bin":$PATH
export VISUAL='vim'  # default GUI editor
export EDITOR="$VISUAL"  # default command line editor
export IGNOREEOF=2  # prevent terminal window from closing on ctrl-d 2 times

# history improvements
export HISTSIZE=100000
export HISTIGNORE='ls:history'  # don't include certain commands in history

# python
export WORKSPACE="$HOME/workspace"
export PYTHON_VENV="$WORKSPACE/python-venv"
export PYTHON_VENV_NAME="my_env"

