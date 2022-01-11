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
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file, {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif

" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" }}}

"End dein Scripts-------------------------

" 各種設定
syntax on
set nocompatible
set tabstop=4
set shiftwidth=4
set softtabstop=4
set encoding=utf-8
set fileencodings=utf-8,iso-2022-jp-3,euc-jisx0213,cp932,euc-jp,sjis,jis,latin,iso-2022-jp
set ambiwidth=double
set expandtab
set smarttab
set cindent
set number
set ruler
set title
set backspace=indent,eol,start
set noswapfile
filetype plugin indent on

" guifont for icons
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete\ 10

" disable conceal
set conceallevel=0

" enable mouse
set mouse=a

" cursor line
set cursorline

" always shows statusline
set laststatus=2

" clipboard
set clipboard=unnamedplus

" tab
set listchars=tab:>-.
set list

" disable preview window in neosnippet candidates.
set completeopt-=preview

" カッコの補完の設定
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" xでヤンクしない
nnoremap x "_x
nnoremap D "_D

" Esc -> Ctrl-J
noremap <C-j> <esc>
noremap! <C-j> <esc>

" color schemeの設定
colorscheme iceberg
autocmd VimEnter,ColorScheme * highlight Normal ctermbg=none
set t_Co=256

" 拡張子別の処理
augroup fileTypeIndent
	autocmd!
	autocmd BufNewFile,BufRead *.rb   setlocal tabstop=2 softtabstop=4 shiftwidth=2
	autocmd BufNewFile,BufRead *.tex  setlocal tabstop=2 softtabstop=4 shiftwidth=2
	autocmd BufNewFile,BufRead *.yml  setlocal tabstop=2 softtabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.toml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

" Makefileを編集するときはインデントにTABを使う
let _curfile=expand("%:r")
if _curfile == 'makefile' || _curfile == 'Makefile'
    set noexpandtab
endif

" ファイルの自動更新
augroup vimrcCheckTime
    autocmd!
    autocmd WinEnter * checktime
augroup END

" 行末のスペースをハイライト
"augroup highlightTrailingSpaces
"    autocmd!
"    autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
"    autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
"augroup END

" IMEの制御
function! ImInActivate()
    call system('fcitx-remote -c')
endfunction
inoremap <silent> <C-[> <ESC>:call ImInActivate()<CR>

" 新規ファイル作成時のテンプレート読み込み
autocmd BufNewFile *.tex 0r $HOME/.template_tex

" let g:deoplete#enable_at_startup = 1

" defx key bind
autocmd FileType defx call s:defx_my_settings()

function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
                \ defx#do_action('open')
    nnoremap <silent><buffer><expr> c
                \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> m
                \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
                \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> l
                \ defx#do_action('open')
    nnoremap <silent><buffer><expr> E
                \ defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> P
                \ defx#do_action('preview')
    nnoremap <silent><buffer><expr> o
                \ defx#do_action('open_tree', 'toggle')
    nnoremap <silent><buffer><expr> K
                \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> N
                \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M
                \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C
                \ defx#do_action('toggle_columns',
                \                'mark:indent:icon:filename:type:size:time')
    nnoremap <silent><buffer><expr> S
                \ defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> d
                \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> r
                \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
                \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x
                \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yy
                \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> .
                \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;
                \ defx#do_action('repeat')
    nnoremap <silent><buffer><expr> h
                \ defx#do_action('cd', ['..'])
    nnoremap <silent><buffer><expr> ~
                \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q
                \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>
                \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> *
                \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j
                \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
                \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l>
                \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>
                \ defx#do_action('print')
    nnoremap <silent><buffer><expr> cd
                \ defx#do_action('change_vim_cwd')
endfunction

call defx#custom#option('_', {
    \ 'winwidth': 40,
    \ 'split': 'no',
    \ 'direction': 'topleft',
    \ 'show_ignored_files': 1,
    \ 'buffer_name': 'explorer',
    \ 'toggle': 1,
    \ 'resume': 1,
    \ 'columns': 'indent:icons:filename:mark'
    \ })

" defx launch bind
nnoremap <silent> <Leader>f :<C-u> Defx <CR>

" defx auto refresh
autocmd BufWritePost * call defx#redraw()
autocmd BufEnter * call defx#redraw()

" Latex Quickrun
if !exists("g:quickrun_config")
    let g:quickrun_config = {}
endif

let g:quickrun_config['tex'] = {
\ 'command' : 'latexmk',
\ 'outputter' : 'error',
\ 'outputter/error/success' : 'null',
\ 'outputter/error/error' : 'quickfix',
\ 'srcfile' : expand("%"),
\ 'cmdopt': '-pdfdvi',
\ 'hook/sweep/files' : [
\                      '%S:p:r.aux',
\                      '%S:p:r.bbl',
\                      '%S:p:r.blg',
\                      '%S:p:r.dvi',
\                      '%S:p:r.fdb_latexmk',
\                      '%S:p:r.fls',
\                      '%S:p:r.log',
\                      '%S:p:r.out'
\                      ],
\ 'exec': '%c %o %a %s',
\ 'runner': 'vimproc',
\ 'runner/vimproc/updatetime': 40,
\}
