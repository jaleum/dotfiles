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

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade

brew install macvim
brew install python
brew install ren  # rename utility command
brew install ripgrep  # faster grep

brew install --cask iterm2
brew install --cask sublime-text
brew install --cask postman

echo_with_prompt "visit this link for setting up solarized in iterm/sublime https://github.com/altercation/vim-colors-solarized"

