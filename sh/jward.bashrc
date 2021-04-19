# source all personal files minus this one

home_dir="$HOME/.jward_bash"
for file in $( ls -A "$home_dir" | grep -v "jward.bashrc" ); do
  source "$home_dir/$file"
done


