set -o nounset -o noclobber -o braceexpand -o emacs
HISTFILE=~/.ksh_history HISTSIZE=5000
export GPG_TTY=$(tty)

function colonize {
	IFS=:
	print "$*"
}
systemPath=$PATH
PATH=$(colonize {,/usr{/local,/pkg,},/opt/pkg,$HOME/.local}/{s,}bin /usr/games)
CDPATH=:$HOME
export PWD

export PAGER=less
export LESS=FRX
export MANSECT=2:3:1:8:6:5:7:4:9
export EDITOR=vim
if whence nvim > /dev/null; then
	EDITOR=nvim
	alias vim=nvim
	export MANPAGER="nvim -c 'set ft=man' -"
fi
FCEDIT=$EDITOR
export GIT_EDITOR=$EDITOR
export CLICOLOR=1
export NETHACKOPTIONS='pickup_types:$!?+/=, color, DECgraphics'

alias ls='ls -p'
alias ll='ls -lh'
alias bc='bc -l'
alias date=ddate
if [[ $(uname) = 'Linux' ]]; then
	alias ls='ls --color=auto' grep='grep --color' rm='rm -I'
fi
alias gs='git status --short --branch || ls' gd='git diff'
alias gsh='git show' gl='git log --graph --pretty=log'
alias gco='git checkout' gb='git branch' gm='git merge' gst='git stash'
alias ga='git add' gmv='git mv' grm='git rm'
alias gc='git commit' gca='gc --amend' gt='git tag'
alias gp='git push' gu='git pull' gf='git fetch'
alias gr='git rebase' gra='gr --abort' grc='gr --continue' grs='gr --skip'
alias rand='openssl rand -base64 33'
alias private='eval "$(gpg -d ~/.private)"'

function colors {
	typeset sgr0=sgr0 setaf=setaf
	[[ -f /usr/share/misc/termcap ]] && sgr0=me setaf=AF
	set -A fg \
		$(tput $sgr0) $(tput $setaf 1) $(tput $setaf 2) $(tput $setaf 3) \
		$(tput $setaf 4) $(tput $setaf 5) $(tput $setaf 6) $(tput $setaf 7)
}
colors

function branch {
	typeset git=.git head
	[[ -d $git ]] || git=../.git
	[[ -d $git ]] || return
	read head < $git/HEAD
	if [[ $head = ref:* ]]; then
		print ":${head#*/*/}"
	else
		typeset -L 7 head
		print ":$head"
	fi
}

hostname=$(hostname)
whence realpath > /dev/null && HOME=$(realpath "$HOME")
function prompt {
	typeset status=$?
	typeset path title right color left cols

	[[ ${PWD#$HOME} != $PWD ]] && path="~${PWD#$HOME}" || path=$PWD
	title=${path##*/}
	right="${path}$(branch)"

	color=${fg[7]}
	if [[ -n ${SSH_CLIENT:-} ]]; then
		color=${fg[5]}
		title="${hostname%%.*}:${title}"
	fi
	(( status )) && color=${fg[1]}
	left="\01${color}\01\$\01${fg}\01 "

	[[ $TERM = xterm* ]] && title="\033]0;${title}\07" || title=''
	[[ -n ${COLUMNS:-} ]] && cols=$COLUMNS || cols=$(tput cols)
	while (( ${#right} > (cols / 2) )); do
		right=${right#*/}
	done
	typeset -R $(( cols - 1 )) right
	print "\01\r\01${title}\01\n\01${fg[7]}${right}${fg}\r\01${left}"
}

PS1='$(prompt)'
