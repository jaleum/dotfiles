# alias vim to use mvim
alias vim="mvim -v"

# git stuff
alias ss="git status"
# alias ph="git push"
alias pl="git pull"
alias aa="git add -A && ss"
alias au="git add -u && ss"
alias gf="git fetch && ss"
alias gd="git diff"
alias gdc="git diff --cached"
alias gl="git log"
alias gs="git stash"
alias gsp="git stash pop"
alias gsl="git stash list"
alias cm="git checkout master"
alias unc="git reset HEAD^"
alias coma="git commit --amend"
alias rb="git rebase origin/master"
alias rbc="git rebase --continue"

# retrieves the current branch
alias cb="git rev-parse --abbrev-ref HEAD"

# helpful bash
alias ls="ls -G"
alias sb="source ~/.zshrc"
alias ll="ls -Al"
alias h="history -100 -1"
alias hg="history 1 | grep"

# random mac fix stuff
alias fclear="osascript -e 'if application \"Terminal\" is frontmost then tell application \"System Events\" to keystroke \"k\" using command down'"
alias sound="sudo killall coreaudiod"
