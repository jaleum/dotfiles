#!/bin/sh

# Bootstraps my environment by linking dotfiles and installing things

# include utils
. "$( pwd )/utils.sh"

# baseline prompt used in utils
PROMPT='[ Bootstrap ]'

# symlink dotfiles, excluding particular files
link () {
  for file in $( ls -A | grep -vE '\.exclude*|\.git$|\.gitignore|\.gitmodules|.*\.md$|.*\.sh$' ) ; do
    echo $file
    ln -sv "$PWD/$file" "$HOME"
  done

  echo_with_prompt "Done linking, ensure .jward_bashrc is referenced in the correct rc/profile file"
}

install_tools () {
  os=$(get_os)
	if [ "$os" = 'darwin' ]; then
    echo_with_prompt "Detected OS macOS"
    execute_func_with_prompt brew_install "brew install"
	else
		echo_with_prompt "Skipping installations using Homebrew because MacOS was not detected..."
	fi
}

brew_install() {
  "$( pwd )/brew.sh"
}


# execute bootstrapping steps
execute_func_with_prompt link "symlink everything"
install_tools

# Hack to make sure this script always exits successfully
# Since the user may choose to cancel a step here
true
