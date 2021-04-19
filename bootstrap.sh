#!/bin/zsh

# Bootstraps my environment by linking dotfiles and installing things

# include utils
. "$( pwd )/utils.sh"

# baseline prompt used in utils
PROMPT='[ Bootstrap ]'

# symlink dotfiles, excluding particular files
link () {
  for file in $( ls -A | grep -vE '\.exclude*|\.git$|\.gitignore|\.gitmodules|.*\.md$|.*\.sh$' ) ; do
    ln -fhsv "$PWD/$file" "${HOME}/.jward_${file}"
  done
}

# creates backup files for the dotfiles
create_backups() {
  bak=".bak"
  files="$@"

  echo_with_prompt "Moving existing dotfiles files into backups"
  for file in "$files"; do
    bak_file=$file$bak

    if [ -f "$bak_file" ]; then
      echo_with_prompt "$bak_file already exist, overwrite? (y/n)"
      read resp
      if [ "$resp" != 'y' ]; then
	echo_with_prompt "Cannot proceed until $bak_file is removed"
	return
      fi
    fi

    echo_with_prompt "Creating $bak_file"
    mv "$file" "$bak_file"
  done
}

# symlinks dotfiles and adds them to base files
setup_dotfiles() {
  zshrc="$HOME/.zshrc"
  vimrc="$HOME/.vimrc"

  create_backups $zshrc $vimrc
  link

  echo_with_prompt "Setting up zshrc and vimrc"
  echo "source ~/.jward_bash/jward.bashrc" > "$zshrc"
  echo "source ~/.jward_vim/jward.vimrc" > "$vimrc"

  source "$zshrc"
}

brew_install() {
  "$( pwd )/brew.sh"
}

install_tools() {
  os=$(get_os)
  if [ "$os" = 'darwin' ]; then
    echo_with_prompt "Detected OS macOS"
    execute_func_with_prompt brew_install "brew install"
  else
    echo_with_prompt "Skipping installations using Homebrew because MacOS was not detected..."
  fi
}

setup_directories() {
  echo_with_prompt "Creating directory at $PYTHON_VENV if it doesn't already exist"
  mkdir -p "$PYTHON_VENV"
}

# initialize python
python_init() {
  currdir=`pwd`

  cd $PYTHON_VENV
  python3 -m venv "$PYTHON_VENV_NAME"
  cd "$currdir"
}

# execute bootstrapping steps
execute_func_with_prompt setup_dotfiles "setup dotfiles"
install_tools
execute_func_with_prompt setup_directories "setup base working directories"
execute_func_with_prompt python_init "initialize python"

# Hack to make sure this script always exits successfully
# Since the user may choose to cancel a step here
true
