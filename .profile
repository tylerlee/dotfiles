# Define the colors
user_color='\[\e[0;31m\]'
pwd_color='\[\e[0;36m\]'
branch_color='\[\e[0;35m\]'
staged_color='\[\e[0;32m\]'
tracked_color='\[\e[0;33m\]'
untracked_color='\[\e[0;31m\]'
reset='\[\e[m\]' # reset

# Store the first user. The first user is never shown, but after a user switch
# any current user that isn't the first user will be shown.
first_user=`whoami`
ps1="$user_color\`whoami | sed -e 's/$/ /' -e '/^$first_user $/d'\`"

# Show the current working directory.
ps1+="$pwd_color\w "

# Show the current git branch if there is one.
ps1+="\`
  git branch --no-color 2> /dev/null |\
  sed -e '/^[^*]/d' -e \"s/^* \(.*\)/$branch_color\1 /\"
\`"

# Show the added, modified, deleted, and untracked counts if there are any.
ps1+="\$(
  status=\`git status --porcelain 2> /dev/null\`
  if [[ \$status ]]
  then
    c=\`echo \"\$status\" | grep -ic '^\\\w'\`
    if [[ \$c -ne 0 ]]; then printf \"$staged_color\$c \"; fi
    c=\`echo \"\$status\" | grep -ic '^.\\\w'\`
    if [[ \$c -ne 0 ]]; then printf \"$tracked_color\$c \"; fi
    c=\`echo \"\$status\" | grep -ic '^??'\`
    if [[ \$c -ne 0 ]]; then printf \"$untracked_color\$c \"; fi
  fi
)"

# Reset the colors.
ps1+=$reset

# Export so PS1 falls through to user switches.
export PS1=$ps1

# For nginx.
export PATH="/usr/local/sbin:$PATH"

# For Homebrew.
export PATH="/usr/local/bin:$PATH"

# For RBENV
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# This Loads NVM
[[ -s /Users/Ty/.nvm/nvm.sh ]] && . /Users/Ty/.nvm/nvm.sh

# autocompletion for git
test -f ~/.git-completion.bash && . $_

## Aliases
alias dc=docker-compose
alias projects="cd ~/Projects/"
alias velcro="cd ~/Projects/velcro"
alias orgsync="cd ~/Projects/orgsync"
alias website="cd ~/Projects/website"
alias heimdall="ssh -N -L 8090:10.179.182.80:8080 -L 8081:10.179.182.80:8081 tlee@54.89.237.185"

## Docker setup
export DOCKER_HOST=tcp://10.109.20.70:2375
export DOCKER_CPUS=8
