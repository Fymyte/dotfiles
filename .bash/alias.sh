alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less


alias la='ls -la'
alias hibernate='systemctl hibernate'

if ${use_color} ; then
    alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
fi

alias gpt='git push origin master --tags'
