export PATH=/usr/local/bin:$PATH

# 補完機能を有効にする
autoload -Uz compinit
compinit

# 色分け
autoload colors
colors
alias ls="gls --color"
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

