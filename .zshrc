# alias
alias vim='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'

# enable completion
autoload -Uz compinit
compinit

# colored
autoload colors
colors

# prompt appearance
PROMPT="%{$fg[green]%}%m%(!.#.$) %{$reset_color%}"
PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]? %{$reset_color%}"
RPROMPT="%{$fg[cyan]%}[%~]%{$reset_color%}"

# pushd automatically when cd
setopt auto_pushd

# not add duplicated dir
setopt pushd_ignore_dups

# global alias
alias -g L='| less'
alias -g G='| grep'

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# for japanese character file
setopt print_eight_bit

# regard after "#" as comment
setopt interactive_comments

# OS setting
[ -f dotfiles/.zshrc_`uname` ] && . dotfiles/.zshrc_`uname`

# settings for depending on machines
[ -f dotfiles/.zshrc_local ] && . dotfiles/.zshrc_local

#Start tmux on every shell login
#https://wiki.archlinux.org/index.php/Tmux#Start_tmux_on_every_shell_login
if which tmux 2>&1 >/dev/null; then
    #if not inside a tmux session, and if no session is started, start a new session
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi

