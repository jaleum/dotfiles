#!/bin/zsh

# Bootstraps my environment by linking dotfiles and installing things

# include utils
. "$( pwd )/utils.sh"

# baseline prompt used in utils
PROMPT='[ Bootstrap ]'
USER="jward"
DOT_PREFIX="${HOME}/.${USER}_"
SHRC="$HOME/.zshrc"

# move the dotfiles repo into the expected location
init() {
  if [ ! -d $DOTFILES ]; then
    echo_with_prompt "Moving dotfiles into $DOTFILES"
    mkdir -p $DOTFILES
    mv `pwd` $DOTFILES
    cd $DOTFILES
  fi
}

# symlink dotfiles, excluding particular files
link () {
  for file in $( ls -A | grep -vE '\..*|.*\.md$|.*\.sh$|company_sh' ) ; do
    ln -fhsv "$PWD/$file" "${DOT_PREFIX}${file}"
  done
}

# creates backup files for the dotfiles
create_backups() {
  bak=".bak"
  files="$@"

  echo_with_prompt "Moving existing dotfiles files into backups"
  for file in $files; do
    bak_file=$file$bak

    if [ -f "$bak_file" ]; then
      echo_with_prompt "$bak_file already exist, overwrite? (y/n)"
      read resp
      if [ "$resp" != 'y' ]; then
	echo_with_prompt "Cannot proceed until $bak_file is removed"
	return 1
      fi
    fi

    echo_with_prompt "Creating $bak_file"
    mv "$file" "$bak_file"
  done
}

add_to_file() {
  line="$1"
  file="$2"
  echo_with_prompt "Adding $line to $file"
  if ! [ cat $file | grep $line ]; then
    echo "$line" >> "$file"
  fi
}

# symlinks dotfiles and adds them to base files
link_dotfiles() {
  vimrc="$HOME/.vimrc"

  create_backups $SHRC $vimrc
  if [ "$?" -ne 0 ]; then
    return 1
  fi

  link

  add_to_file "source ${DOT_PREFIX}sh/${USER}.shrc" "$SHRC"
  add_to_file "source ${DOT_PREFIX}vim/${USER}.vimrc" "$vimrc"

  source "$SHRC"
}

# create company specifc dotfiles files
create_company_dotfiles() {
  company_dotfiles="${WORKSPACE}/company_dotfiles"

  if [ -d $company_dotfiles ]; then
    echo_with_prompt "$company_dotfiles already exists"
    return
  fi

  echo_with_prompt "Creating directory at $company_dotfiles"
  mkdir -p "$company_dotfiles"
  cd $company_dotfiles

  echo_with_prompt "Initializing git repo"
  git init
  cp -R $DOTFILES/company_sh $company_dotfiles/sh
  git add -A && git commit -m "init"

  company_sh="$HOME/.company_sh"
  # create a symbolic link to the company dotfiles, overwritting anything existing
  ln -fhsv $company_dotfiles $company_sh

  echo_with_prompt "Adding company.shrc to $SHRC"
  company_shrc_source="source $company_sh/company.shrc"
  if ! [ cat $SHRC | grep $company_shrc_source ]; then
    echo $company_shrc_source >> "$SHRC"
    source "$SHRC"
  fi

  cd $DOTFILES
}

install_tools() {
  os=$(get_os)
  if [ "$os" = 'darwin' ]; then
    echo_with_prompt "Detected OS macOS"
    execute_func_with_prompt "$DOTFILES/brew.sh" "brew install"
  else
    echo_with_prompt "Skipping installations using Homebrew because MacOS was not detected..."
  fi
}

# initialize python
python_init() {
  if [ -d $PYTHON_VENV ]; then
    echo_with_prompt "$PYTHON_VENV already exists"
    return
  fi

  echo_with_prompt "Creating directory at $PYTHON_VENV_DIR if it doesn't already exist"
  mkdir -p "$PYTHON_VENV_DIR"
  cd $PYTHON_VENV_DIR

  echo_with_prompt "Creating virtual environment '$PYTHON_VENV_NAME'"
  python3 -m venv "$PYTHON_VENV_NAME"

  cd $DOTFILES
}

# execute bootstrapping steps
init
execute_func_with_prompt link_dotfiles "link dotfiles"
execute_func_with_prompt create_company_dotfiles "create company dotfiles"
install_tools
execute_func_with_prompt python_init "initialize python"

# Hack to make sure this script always exits successfully
# Since the user may choose to cancel a step here
true
