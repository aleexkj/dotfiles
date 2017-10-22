# term
export TERM="xterm-256color"

# Oh-my-Zsh
export ZSH=/home/kreiz/.oh-my-zsh
source $HOME/.zsh_prompt
ZSH_THEME="powerlevel9k/powerlevel9k"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Plugins
plugins=(git wd zsh-autosuggestions web-search history)

# zshrc
source $ZSH/oh-my-zsh.sh
alias zshconfig="vim ~/.zshrc"
alias zshload="source ~/.zshrc"

# User config
export LANG="en_US.UTF-8"
export EDITOR='vim'
export SSH_KEY_PATH="~/.ssh/id_rsa"
alias bed="please shutdown now"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=cyan'

# ZSH config
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}'
zstyle :compinstall filename '$HOME/.zshrc'

autoload -Uz compinit
compinit

setopt correct
setopt correctall

autoload -Uz promptinit
promptinit
autoload -Uz colors
colors

setopt histignoredups

## Git
alias gfire="gaa; gcmsg 'Fire'; ggpush"
alias gprune="prune_local_branches"
alias gbrl="g branch -vv"

prune_local_branches(){
	gcm
	ggpull
	gfa
	# delete local branch: for all merged, not master
	for branch in $(git for-each-ref --format='%(refname)' --merged HEAD  --no-contains HEAD refs/heads/ | sed 's/refs\/heads\///');
	do
		g branch -d "$branch"
	done
	g stash clear
}

gco!(){
	gco $1
	ggpull --rebase
}
compdef _git-checkout gco!

gdrop(){
	g reset --hard
	g clean -i
}


# Personal alias
source $HOME/.aliases

# Other alias
alias ls=" exa"
alias la="ls --almost-all"
alias lla=" exa -la"
alias ip="ip -c address show"

