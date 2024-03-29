#!/bin/sh

# Utility functions that other dotfiles use

echo_with_prompt () {
  PROMPT="${PROMPT:-'[ jacobw_dotfiles ]'}"
  echo "$PROMPT $@"
}

execute_func_with_prompt() {
  # Args
  # $1 - the function to call
  # $2 - the thing this function does
  # Returns 1 if the user cancels the operation
  # Returns 2 if the function failed
  # Returns 0 if all went well

  echo_with_prompt "This utility will $2"
  echo_with_prompt "Proceed? (y/n)"
  read resp
  if [ "$resp" = 'y' ]; then
    # Call the function
    "$1" || return 2
    echo_with_prompt "$2 complete"
  else
    echo_with_prompt "$2 cancelled by user"
    return 1
  fi
}

get_os() {
  if [ $( echo "$OSTYPE" | grep 'darwin' ) ] ; then
    os='darwin'
  elif [ $( echo "$OSTYPE" | grep 'linux-gnu' ) ] ; then
    # This file contains all the details you need!
    source /etc/os-release
    # Set os to ID_LIKE if this field exists
    # Else default to ID
    # ref. https://www.freedesktop.org/software/systemd/man/os-release.html#:~:text=The%20%2Fetc%2Fos%2Drelease,like%20shell%2Dcompatible%20variable%20assignments.
    os="${ID_LIKE:-$ID}"
  else
    os='unknown'
  fi

  # "return" the result
  echo "$os"
}
