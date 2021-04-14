# source all personal files minus this one

home_dir="$HOME/.jward_bash"
for file in $( ls -A "$home_dir" | grep -v "jward.bashrc" ); do
  source "$home_dir/$file"
done

# zsh completion more like bash
setopt BEEP NO_AUTOLIST BASH_AUTOLIST NO_MENUCOMPLETE no_always_last_prompt noautomenu 
setopt globdots  # allow dotfiles to be suggested without the leading dot
