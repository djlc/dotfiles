if !&compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" dein settings {{{
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.vim') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/.dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

" 引数なしでvimを開くとNERDTreeを起動
let file_name = expand('%')
if has('vim_starting') &&  file_name == ''
  autocmd VimEnter * NERDTree ./
endif

"End dein Scripts-------------------------

syntax on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set ambiwidth=double
set expandtab
set autoindent
set smartindent
set number

" 拡張子別の処理
augroup fileTypeIndent
	autocmd!
	autocmd BufNewFile, BudRead *.rb  setlocal tabstop=2 softtabstop=4 shiftwidth=2
	autocmd BufNewFile, BudRead *.yml setlocal tabstop=2 softtabstop=2 shiftwidth=2
	autocmd BufNewFile, BudRead *.toml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

augroup vimrcCheckTime
    autocmd!
    autocmd WinEnter * checktime
augroup END
