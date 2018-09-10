autoload colors zsh/terminfo
colors

precmd() { print "" }
PS1="$⟩ "
RPS1="%{$fg[magenta]%}%100<...<%~%<<%{$reset_color%}"

if [ "$TMUX" = "" ]; then tmux; fi

setopt auto_cd

setopt correctall
alias git status='nocorrect git status'

source $(brew --prefix)/share/antigen/antigen.zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle git
antigen apply

alias vim="nvim"
alias ls='ls -GFhlxort'
alias hg='history | grep "$@"'
alias work='cd ~/Dropbox/Workspace'
alias thompsons='ssh zak@thethompsonfamily.ca'
alias nvm_update='echo "About to update NVM:"; cd $NVM_DIR; git fetch -p; git checkout \$(git describe --tags \`git rev-list --tags --max-count=1\`); source $NVM_DIR/nvm.sh; cd $OLDPWD'
alias pi='ssh pi@zakthompson.me'
alias qbc='ssh zak@159.203.35.109'
alias fire='ssh zak@thisfireinside.com'

export NVM_DIR="/Users/Zak/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
