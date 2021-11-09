# PATH
export PATH=/usr/local/texlive/2021/bin/x86_64-linux/:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/opt/riscv/bin:$PATH
export PATH=~/.deno/bin:$PATH

# 補完機能を有効にする
autoload -Uz compinit
compinit

# 色分け
autoload colors
colors

# プロンプトの表示設定
PROMPT="%{$fg[green]%}%m%(!.#.$) %{$reset_color%}"
PROMPT2="%{$fg[green]%}%_> %{$reset_color%}"
SPROMPT="%{$fg[red]%}correct: %R -> %r [nyae]? %{$reset_color%}"
RPROMPT="%{$fg[cyan]%}[%~]%{$reset_color%}"

# cdしたら自動的にpushdする
setopt auto_pushd

# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# global alias
alias -g L='| less'
alias -g G='| grep'

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# '#'以降をコメントとして扱う
setopt interactive_comments

# OS別の設定
[ -f dotfiles/.zshrc_`uname` ] && . dotfiles/.zshrc_`uname`

# マシン依存の設定
[ -f dotfiles/.zshrc_local ] && . dotfiles/.zshrc_local

#Start tmux on every shell login
#https://wiki.archlinux.org/index.php/Tmux#Start_tmux_on_every_shell_login
if which tmux 2>&1 >/dev/null; then
    #if not inside a tmux session, and if no session is started, start a new session
    test -z "$TMUX" && (tmux attach || tmux new-session)
fi

