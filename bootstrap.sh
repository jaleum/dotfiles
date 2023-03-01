#!/bin/zsh

# Bootstraps my environment by linking dotfiles and installing things

# include utils
. "$( pwd )/utils.sh"

# this script relies on exports existing already
. "$( pwd )/sh/exports.shrc"

# baseline prompt used in utils
PROMPT='[ Bootstrap ]'
USER="jacobw"
DOT_PREFIX="${HOME}/.${USER}_"
SHRC="$HOME/.zshrc"

# move the dotfiles repo into the expected location
init() {
  if [ ! -d $DOTFILES ]; then
    echo_with_prompt "Moving dotfiles into $DOTFILES"
    mkdir -p $DOTFILES
    mv `pwd` $WORKSPACE
    cd $DOTFILES
  fi
}

init_zsh() {
  if [ ! -d $ZSH_PLUGINS ]; then
    mkdir -p $ZSH_PLUGINS
  fi

  cd $ZSH_PLUGINS
  git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_PLUGINS/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git
  git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH_PLUGINS/ohmyzsh

  cd $DOTFILES
}
# symlink dotfiles, excluding particular files
link () {
  for file in $( ls -A | grep -vE '\..*|.*\.md$|.*\.sh$|company_sh' ) ; do
    ln -fhsv "$PWD/$file" "${DOT_PREFIX}${file}"
  done
}

append_to_file() {
  line="$1"
  file="$2"
  echo_with_prompt "Appending '$line' to '$file'"

  # append the line to the file if it doesn't exit
  if ! grep -q "$line" $file; then
    echo "$line" >> "$file"
  fi
}

# symlinks dotfiles and adds them to base files
link_dotfiles() {
  link

  append_to_file "source ${DOT_PREFIX}sh/${USER}.shrc" "$SHRC"
  append_to_file "source ${DOT_PREFIX}vim/${USER}.vimrc" "$HOME/.vimrc"

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
  local_company_sh="$company_dotfiles/sh"
  cp -R $DOTFILES/company_sh $local_company_sh
  git add -A && git commit -m "init"

  # create a symbolic link to the company dotfiles, overwritting anything existing
  home_company_sh="$HOME/.company_sh"
  ln -fhsv $local_company_sh $home_company_sh

  append_to_file "source $home_company_sh/company.shrc" "$SHRC"
  source "$SHRC"

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
execute_func_with_prompt init_zsh "download zsh plugins"
execute_func_with_prompt link_dotfiles "link dotfiles"
execute_func_with_prompt create_company_dotfiles "create company dotfiles"
install_tools
execute_func_with_prompt python_init "initialize python"

echo_with_prompt "Bootstrap complete!"

# Hack to make sure this script always exits successfully
# Since the user may choose to cancel a step here
true
