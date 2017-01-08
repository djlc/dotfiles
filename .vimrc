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

"End dein Scripts-------------------------

" Shougo/neocomplete.vim' {{{
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"""}}}

" neosnippetの設定
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" quickrunの設定
let g:quickrun_config = {
\   '_' : {
\   'runner' : 'vimproc',
\   'runner/vimproc/updatetime' : 60,
\   'outputter' : 'error',
\   'outputter/error/success' : 'null',
\   'outputter/error/error' : 'quickfix',
\   'outputter/buffer/split' : 'bo 8sp',
\   'outputter/buffer/close_on_empty' : 1,
\   },
\   'tex' : {
\   'command' : 'latexmk',
\   'srcfile' : expand("%"),
\   'cmdopt': '-pdfdvi',
\   'hook/sweep/files' : [
\                      '%S:p:r.aux',
\                      '%S:p:r.bbl',
\                      '%S:p:r.blg',
\                      '%S:p:r.dvi',
\                      '%S:p:r.fdb_latexmk',
\                      '%S:p:r.fls',
\                      '%S:p:r.log',
\                      '%S:p:r.out'
\                      ],
\   'exec': '%c %o %a %s',
\   },
\   'py' : {
\   'command' : 'python',
\   'srcfile' : expand("%"),
\   'exec': '%c %a',
\   },
\}

" clangの設定
let g:marching_clang_command = "/usr/bin/clang"
" includeディレクトリ
let g:marching_include_paths = [
\   "/usr/include"
\]
" nwocomplete.vimと併用
let g:marching_enable_neocomplete = 1

" previmの設定
let g:previm_enable_realtime = 1
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

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

" カッコの補完の設定
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

" tabで括弧の外に出る
noremap <silent> <C-f> <ESC>/)\\|}\\|]\\|"\\|'<CR>a
inoremap <silent> <C-f> <ESC>/)\\|}\\|]\\|"\\|'<CR>a

" xでヤンクしない
nnoremap x "_x
nnoremap D "_D

" color schemeの設定
colorscheme koehler
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
augroup highlightTrailingSpaces
    autocmd!
    autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
    autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END

" IMEの制御
function! ImInActivate()
    call system('fcitx-remote -c')
endfunction
inoremap <silent> <C-[> <ESC>:call ImInActivate()<CR>

" 実行コマンド
function! Run()
    let e = expand("%:e")
    if e == "c"
        :w
        :!gcc % -o %:r
        :!./%:r
    endif
    if e == "cpp"
        :w
        :!g++ % -o %:r
        :!./%:r
    endif
    if e == "tex"
        :w
        :lcd %:h
        :!latexmk %
    endif
endfunction

command! Exec call Run()
nnoremap <F5> :Exec<CR><CR>

" 新規ファイル作成時のテンプレート読み込み
autocmd BufNewFile *.tex 0r $HOME/.template_tex

