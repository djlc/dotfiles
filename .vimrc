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

" 'justmao945/vim-clang' {{{

" disable auto completion for vim-clanG
let g:clang_auto = 1
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

if executable('clang-3.6')
    let g:clang_exec = 'clang-3.6'
elseif executable('clang-3.5')
    let g:clang_exec = 'clang-3.5'
elseif executable('clang-3.4')
    let g:clang_exec = 'clang-3.4'
else
    let g:clang_exec = 'clang'
endif

if executable('clang-format-3.6')
    let g:clang_format_exec = 'clang-format-3.6'
elseif executable('clang-format-3.5')
    let g:clang_format_exec = 'clang-format-3.5'
elseif executable('clang-format-3.4')
    let g:clang_format_exec = 'clang-format-3.4'
else
    let g:clang_exec = 'clang-format'
endif

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'

" }}}

" syntaxの設定
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1
let g:syntastic_mode_map = {'mode': 'passive'}
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

augroup AutoSyntastic
    autocmd!
    autocmd InsertLeave,TextChanged * call s:syntastic()
augroup END

function! s:syntastic()
    w
    SyntasticCheck
endfunction

" endwiseの設定
let g:endwise_no_mappings=1

" previmの設定
let g:previm_enable_realtime = 1
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

" 各種設定
syntax on
set tabstop=4
set shiftwidth=4
set softtabstop=4
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
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

" 行末にカーソルを持っていく設定
inoremap <C-e> <Esc>$a
noremap <C-e> <Esc>$a

" カッコの補完の設定
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
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
	autocmd BufNewFile,BufRead *.yml  setlocal tabstop=2 softtabstop=2 shiftwidth=2
	autocmd BufNewFile,BufRead *.toml setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END

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
endfunction

command! Gcc call Run()
nnoremap <F5> :Gcc<CR><CR>

