#!/bin/sh

# Install command-line tools using Homebrew.

# include utils
. "$( pwd )/utils.sh"

# Install homebrew if it is not installed
which brew 1>&/dev/null
if [ ! "$?" -eq 0 ] ; then
  echo_with_prompt "Homebrew not installed. Attempting to install Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ ! "$?" -eq 0 ] ; then
    echo_with_prompt "Something went wrong. Exiting..." && exit 1
  fi
fi

# Add brew to PATH
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

brew install macvim
brew install python
brew install ren  # rename utility command
brew install ripgrep  # faster grep

execute_func_with_prompt install_fzf "install fzf"
execute_func_with_prompt install_dev_apps "install dev apps"

# https://github.com/jakehilborn/displayplacer used for fixing mac displays always re-arranging.
brew tap jakehilborn/jakehilborn && brew install displayplacer

echo_with_prompt "visit this link for setting up solarized in iterm/vim/intellij https://github.com/altercation/solarized"
echo_with_prompt "visit this link for setting up solarized in sublime https://packagecontrol.io/packages/Solarized%20Color%20Scheme"

install_dev_apps() {
  brew install --cask iterm2
  brew install --cask sublime-text
  brew install --cask postman
}

install_fzf() {
  brew install fzf

  # To install useful key bindings and fuzzy completion:
  $(brew --prefix)/opt/fzf/install

  # fzf config to allow alt c for change directory
  bindkey "ç" fzf-cd-widget
  # fzf uses ripgrep by default
  export FZF_DEFAULT_COMMAND="rg --files --hidden"
}
