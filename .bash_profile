export HISTSIZE=99999
export HISTFILESIZE=999999
export HISTCONTROL=ignoreboth
export HISTIGNORE="df*:tig:gpull:gpush:cd*:ping*"

PATH=~/bin:$PATH

alias g='git status -uno'
alias b='git symbolic-ref --short HEAD'
alias gpush='git push origin `git symbolic-ref --short HEAD`'
alias gpull='git fetch origin && git pull origin `git symbolic-ref --short HEAD`'

if [ -f ~/.git-completion.bash ]; then
      . ~/.git-completion.bash
fi


