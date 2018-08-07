" inferring where we are

if $XDG_CONFIG_HOME == ''
    let $XDG_CONFIG_HOME = '~/.config'
    if has("win32")
        let $XDG_CONFIG_HOME = '~/AppData/Local'
    endif
    let $XDG_CONFIG_HOME = fnamemodify($XDG_CONFIG_HOME,":p")
endif

let s:vim_dir = $HOME . "/.vim"

if has("win32")
    let s:vim_dir = $USERPROFILE . "/vimfiles"
endif

if has("nvim")
    let s:vim_dir = $XDG_CONFIG_HOME . "/nvim"
endif

if $MYVIMRC == ''
    let s:vim_dir = expand('<sfile>:p:h')
endif

" are we using ssh?
let s:ssh_client = 0

if $SSH_CLIENT != ''
    let s:ssh_client = 1
endif

" Subsection: settings {{{

set enc=utf-8

set nocompatible
syntax on

set ttimeoutlen=0
set laststatus=2
set listchars=eol:¬,tab:»\ ,trail:·
set splitbelow
set splitright
set number
set relativenumber
set wildmenu
if has("linebreak")
    set breakindent
endif
set linebreak
set autoindent
set hlsearch
set hidden
set nostartofline
set fileformats=unix,dos
set fileformat=unix
set backspace=indent,eol,start
if has("win32")
    set shellslash
endif
set incsearch
set nojoinspaces
set ignorecase
set smartcase
set noruler

"show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
set expandtab

set mouse=a

" mouse selection yanks to the system clipboard when using ssh
if s:ssh_client
    set mouse=
endif

if has("path_extra")
    set fileignorecase
endif

" setting dir

if !has("nvim")
    let s:swap_dir = s:vim_dir."/swap"
    exe "let s:has_swap_dir = isdirectory('".s:swap_dir."')"
    if !s:has_swap_dir
        call mkdir(s:swap_dir)
    endif
    let &dir=s:swap_dir."//"
endif

" }}}

" Subsection: mappings — pt-BR keyboard {{{1

" cedilla is right where : is on a en-US keyboard
nmap ç :
vmap ç :
nmap Ç :<up><cr>
vmap Ç :<up><cr>
nnoremap ¬ ^
nnoremap qç q:
vnoremap qç q:
vnoremap ¬ ^

nnoremap <f1> :vert h<space>
vnoremap <f1> <esc>:vert h

nnoremap <silent> <Esc><Esc> <Esc>:only<CR>

" clear search highlights

nnoremap <silent> <f2> :set invhlsearch hlsearch?<cr>

" easier window switching
nnoremap <C-H> <C-W>h
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l

vnoremap <C-H> <esc><C-W>h
vnoremap <C-J> <esc><C-W>j
vnoremap <C-K> <esc><C-W>k
vnoremap <C-L> <esc><C-W>l

nnoremap <leader>v <C-w>v
nnoremap <leader>h <C-w>s

nnoremap <leader>i :set invpaste paste?<CR>

if has("clipboard")
    " win32 and X11 registers
    nnoremap <silent> <leader>yy "+yy:let @*=@"<cr>
    nnoremap <silent> <leader>p "+p
    vnoremap <silent> <leader>p "+p
    vnoremap <silent> <leader>y "+y:let @*=@"<cr>
endif

nnoremap <silent> <leader>R :set relativenumber!<cr>

" filtering line under cursor
nnoremap <silent> <leader><F3> :.!<C-R>=getline('.')<CR><cr>
" executing range
vnoremap <F3> :w !$SHELL<CR>
" evaluating selection
vnoremap <F4> y:@"<CR>
" executing line under cursor
nnoremap <F3> :.w !$SHELL<CR>
" evaluating line under cursor
nnoremap <F4> :execute getline(".")<CR>

nnoremap <leader><F5> :ls<CR>:buffer<Space>
nnoremap <F6> :w<CR>
nnoremap <leader><F7> :find<space>
nnoremap <leader><F6> :w!<CR>
nnoremap <silent> <F12>  :setlocal list!<CR>
nnoremap <leader>\| :setlocal wrap! wrap?<CR>
nnoremap <silent> <leader>N :setlocal number!<CR>
nnoremap <leader>N :set linebreak! linebreak?<CR>
vnoremap . :normal .

inoremap <F6> <esc>:w<CR>

nnoremap <silent> <F9> :q<cr>
nnoremap <silent> <leader><F9> :bw<cr>

" quickfix and locallist

nnoremap <silent> <leader>l :lopen<CR>
nnoremap <silent> <leader>L :lclose<CR>
nnoremap <silent> <leader>q :copen<CR>
nnoremap <silent> <leader>Q :cclose<CR>

nnoremap <silent> <leader>B :b#<CR>

" force case sensitivity for *-search
nnoremap <Plug>CaseSensitiveStar /\C\V\<<c-r>=expand("<cword>")<cr>\><cr>
nmap <kmultiply> <Plug>CaseSensitiveStar
nmap * <Plug>CaseSensitiveStar

" neovim terminal
if has("nvim")
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    tnoremap <leader><Esc> <C-\><C-n>
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
endif

if has("gui_running") || has("nvim")
    " For Emacs-style editing on the command-line >
    " start of line
    cnoremap <C-A> <Home>
    " back one character
    cnoremap <C-B> <Left>
    " delete character under cursor
    cnoremap <C-D> <Del>
    " end of line
    cnoremap <C-E> <End>
    " forward one character
    cnoremap <C-F> <Right>
    " recall newer command-line
    cnoremap <C-N> <Down>
    " recall previous (older) command-line
    cnoremap <C-P> <Up>
    " back one word
    cnoremap <M-b> <S-Left>
    " forward one word
    cnoremap <M-f> <S-Right>
    " cancel
    cnoremap <C-G> <C-C>
    " open the command line buffer
    cnoremap <C-Z> <C-F>
endif

" inserting the current line
cnoremap <c-r><c-l> <c-r>=getline(".")<cr>
" inserting the current line number
cnoremap <c-r><c-n> <c-r>=line(".")<cr>

" emacs c-k behaviour
inoremap <c-k> <c-o>D
cnoremap <c-k> <c-f>D<c-c><c-c>:<up>
" remapping digraph
inoremap <c-s> <c-k>
cnoremap <c-s> <c-k>

" merge

command! JumpToNextMergeConflictLeft   :keepp keepj ?^<<<<<<<
command! JumpToNextMergeConflictMiddle :keepp /^=======
command! JumpToNextMergeConflictRight  :keepp keepj /^>>>>>>>

nnoremap <silent> <leader>cr :JumpToNextMergeConflictRight<cr>
nnoremap <silent> <leader>cm :JumpToNextMergeConflictMiddle<cr>
nnoremap <silent> <leader>cl :JumpToNextMergeConflictLeft<cr>

" }}}

" Subsection: commands

" Copying the current buffer's path to the system clipboard

command! FullPath :let @*=expand('%:p:~') | let @+=@* | let @"=@*
command! Path :let @*=expand('%') | let @+=@* | let @"=@*
command! Name :let @*=expand('%:t') | let @+=@* | let @"=@*

" Subsection: autocommands {{{

" buffer aesthetics

function! s:Aesthetics()
    if &ft =~ "netrw"
        return
    endif
    " setting nonumber if length of line count is greater than 3
    if len(line("$"))>3
        setlocal nonumber
    endif
endfun

augroup AestheticsAutoGroup
    autocmd!
    autocmd BufRead * call s:Aesthetics()
augroup END

"help buffers

augroup HelpAutoGroup
    autocmd!
    autocmd FileType help,eclimhelp au BufEnter <buffer> setlocal relativenumber
augroup END

" svn commit files

augroup SvnFtGroup
    autocmd!
    autocmd BufEnter *.svn set ft=svn
augroup END

" infercase

augroup InferCaseGroup
    autocmd!
    autocmd FileType gitcommit,text,svn,mail setlocal ignorecase infercase
augroup END

" XML

let s:LargeXmlFile = 1024 * 512
augroup XmlAutoGroup
    autocmd BufRead * if &filetype ==# "xml" | let f=expand("<afile>")
            \| if getfsize(f) > s:LargeXmlFile | setlocal syntax=unknown | endif | endif
augroup END

" norelativenumber in insert mode
augroup RelativeNumberAutoGroup
    autocmd InsertEnter * if &number | :set norelativenumber | endif
    autocmd InsertLeave * if &number | :set relativenumber | endif
augroup END

" text format options

augroup TextFormatAutoGroup
    au!
    autocmd FileType text,svn setlocal textwidth=80
augroup END

" diff options

" reverting wrap to its global value when in diff mode
augroup DiffWrapAutoGroup
    autocmd FilterWritePre * if &diff | setlocal wrap< | endif
augroup END

" VimEnter

augroup VimEnterAutoGroup
    au!
    " v:vim_did_enter not available before 8.0
    au VimEnter * let g:vim_did_enter = 1
    " statusline
    au VimEnter * call statusline#initialize()
augroup END

" }}}

" sourcing init.local.vim if it exists

let s:init_local = s:vim_dir . "/init.local.vim"
if filereadable(s:init_local)
  execute 'source ' . s:init_local
endif

" sourcing ginit.vim if it exists

if has("gui_running")
    if $MYGVIMRC == ''
        let s:ginit = s:vim_dir . "/ginit.vim"
        if filereadable(s:ginit)
          execute 'source ' . s:ginit
        endif
    endif
endif

" sourcing ginit.local.vim if it exists

if has("gui_running")
    let s:ginit_local = s:vim_dir . "/ginit.local.vim"
    if filereadable(s:ginit_local)
      execute 'source ' . s:ginit_local
    endif
endif

" Subsection: plugins {{{

" netrw

let g:netrw_bufsettings = 'noma nomod number relativenumber nobl wrap ro hidden'
let g:netrw_liststyle = 3

" Eclim

let g:EclimLogLevel = 'info'

let g:EclimHighlightError = "Error"
let g:EclimHighlightWarning = "Ignore"

let g:EclimXmlValidate=0
let g:EclimXsdValidate=0
let g:EclimDtdValidate=0

let g:EclimMakeLCD = 1
let g:EclimJavaSearchSingleResult = 'edit'

" }}}

" Subsection: packages

if !has('packages')
    finish
endif

if !has("nvim")
    packadd matchit
endif

" Subsection: package customisation {{{

" CamelCase

map <silent> <leader>w <Plug>CamelCaseMotion_w
map <silent> <leader>b <Plug>CamelCaseMotion_b
map <silent> <leader>e <Plug>CamelCaseMotion_e
map <silent> <leader>ge <Plug>CamelCaseMotion_ge

" ctrlp
let g:ctrlp_working_path_mode = ''
let g:ctrlp_reuse_window = 'netrw\|help'
let s:ctrlp_custom_ignore = {
            \ 'file': '\v\.o$|\.exe$|\.lnk$|\.bak$|\.swp$|\.class$|\.jasper$'
            \               . '|\.r[0-9]+$|\.mine$',
            \ 'dir': '\C\V' . escape(expand('~'),' \') . '\$\|'
            \               . '\v[\/](classes|target|build|test-classes|dumps)$'
            \ }

let g:ctrlp_custom_ignore = deepcopy(s:ctrlp_custom_ignore)

let g:ctrlp_switch_buffer = 't'
let g:ctrlp_map = '<f7>'
let g:ctrlp_tabpage_position = 'bc'
let g:ctrlp_match_window = 'bottom,order:ttb,min:1,max:10,results:10'
let g:ctrlp_clear_cache_on_exit = 0
nnoremap <silent> <F5> :CtrlPBuffer<cr>

" vim-rzip
let g:rzipPlugin_extra_ext = '*.odt'

" solarized

let s:enable_solarized = 1

if !has("nvim") && !has("gui_running") && s:ssh_client
    let s:enable_solarized = 0
endif

if has("win32unix")
    let s:enable_solarized = 0
endif

if s:enable_solarized
    set cursorline
    let g:solarized_italic = 1
    colorscheme solarized
    set background=dark
    if exists("g:vim_did_enter")
        call statusline#initialize()
    endif
endif

" paredit
let g:paredit_leader = '\'

" syntastic
" autocmd FileType java SyntasticToggleMode
let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': []}
let g:syntastic_java_javac_config_file_enabled = 1

" sneak
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

map x <Plug>Sneak_s
map X <Plug>Sneak_S

" scalpel
nmap <Leader>x <Plug>(Scalpel)

" Glaive
augroup GlaiveInstallGroup
    autocmd!
    autocmd VimEnter * call glaive#Install()
augroup END

" LargeFile
let g:LargeFile=1.5

" dbext

function! DBextPostResult(...)
    " removing an undesirable mapping
    unmap <buffer> q
endfunction

" }}}

"  vim: fdm=marker
