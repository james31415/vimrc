if has('vim_starting')
    if &compatible
        set nocompatible
    endif
endif

if has('win32')
    set runtimepath+=~/vimfiles/bundle/vundle.vim
    call vundle#begin(expand('~/vimfiles/bundle/'))
else
    set runtimepath+=~/.vim/bundle/Vundle.vim
    call vundle#begin(expand('~/.vim/bundle/'))
endif

Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'

Plugin 'drmikehenry/vim-headerguard'

Plugin 'tpope/vim-surround'

Plugin 'Raimondi/delimitMate'

Plugin 'rust-lang/rust.vim'

Plugin 'tpope/vim-vinegar'

Plugin 'majutsushi/tagbar'

call vundle#end()

" Filetype detection {{{
syntax on
filetype on
filetype plugin indent on
set cinoptions=(0,=0
"}}}

let mapleader=","

" Options {{{
" Graphical settings {{{
set statusline=%<[%n]\ %f\ %y\ %h%m%r%=%{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}%{\"[\".&ff.\"]\"}%{fugitive#statusline()}%k\ %-14.(%l,%c%V%)\ %P
set guioptions-=T
set guioptions-=m
set number

hi StatusLine ctermfg=Yellow ctermbg=Blue
hi ColorColumn ctermbg=DarkRed guibg=DarkRed
call matchadd("ColorColumn", '\%81v', 100)

if has("gui_running")
    colorscheme evening
    set guifont=DejaVu_Sans_Mono:h10:cANSI
    set lines=50
    set columns=150
else
    colorscheme desert
endif
"}}}

" Directories {{{
if has('win32')
    set directory=$HOME/vimfiles/swap
    set bdir=$HOME/vimfiles/backup
    set viewdir=$HOME/vimfiles/view
else
    set directory=$HOME/.vim/swap
    set bdir=$HOME/.vim/backup
    set viewdir=$HOME/.vim/view
endif

set grepprg=grep\ -n
"}}}

" Miscellaneous {{{
set nowrap
set incsearch
set laststatus=2
set backspace=indent,eol,start
set confirm
set wildmenu
set hidden

if !&scrolloff
    set scrolloff=5
endif
if !&sidescrolloff
    set sidescrolloff=5
endif
set display+=lastline,uhex
set autoindent
set copyindent
set shiftround
set smarttab

set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.
if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    set fileencodings=ucs-bom,utf-8,latin1
endif

if &encoding ==# 'latin1' && has('gui_running')
    set encoding=utf-8
endif

if &history < 1000
    set history=1000
endif
"}}}

" Tabs {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
"}}}

" Mappings {{{
vmap Q gq
nmap Q gqap

nnoremap <silent> <Leader>cd :cd %:p:h<cr>
nnoremap <space> @@
inoremap jk <Esc>

" Special Files {{{
nnoremap <Leader>ev :e $MYVIMRC<cr>
nnoremap <silent> gf :e <cfile><cr>
"}}}

" Fugitive {{{
augroup ft_fugitive
    autocmd!

    autocmd BufNewFile,BufRead .git/index setlocal nolist
augroup END
"}}}

" Splits {{{
nnoremap <Leader>H :lefta :vnew<cr>
nnoremap <Leader>K :abo :new<cr>
nnoremap <Leader>L :rightb :vnew<cr>
nnoremap <Leader>J :bel :new<cr>

nnoremap <Leader>h <C-W><Left>
nnoremap <Leader>j <C-W><Down>
nnoremap <Leader>k <C-W><Up>
nnoremap <Leader>l <C-W><Right>

set wmh=0
nnoremap <Leader>m <C-W>=
nnoremap <Leader>M <C-W>_
"}}}

" Keyword search {{{
vnoremap <silent> <Leader>s y/<C-R>"<cr>
vnoremap <silent> <Leader>S y:%s/<C-R>"//n<cr>
"}}}

" Function Key definitions {{{
nnoremap <silent> <C-F2> :if &guioptions =~# 'T' <Bar>
                         \set guioptions-=T <Bar>
                         \set guioptions-=m <Bar>
                    \else <Bar>
                         \set guioptions+=T <Bar>
                         \set guioptions+=m <Bar>
                    \endif<cr>
nnoremap <silent> <F4> :UB<cr>

nnoremap <silent> <F5> :e<cr>
nnoremap <silent> <C-F5> :e<cr>G
nnoremap <silent> <F7> :set hls!<cr>
nnoremap <silent> <F8> :set nu!<cr>

nnoremap <silent> <F11> :TagbarToggle<cr>
nnoremap <silent> <F12> :e #<cr>
"}}}
"}}}

" Autocommands {{{
function! Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunction

" Filetype: C,CPP {{{
augroup filetype_c
    autocmd!
    autocmd FileType c,cpp let g:headerguard_newline=1
    autocmd FileType c,cpp let b:delimitMate_expand_cr = 1
    autocmd FileType c,cpp setlocal makeprg=build.bat
    autocmd FileType c,cpp nnoremap <buffer> <silent> <Leader>g :HeaderguardAdd<cr>
    autocmd FileType c,cpp nnoremap <buffer> <silent> <Leader>c Iclass <Esc>o{<cr>};<Esc>ko
    autocmd FileType c,cpp nnoremap <buffer> <silent> <Leader>es :exe "e " . expand("%:r") . ".cpp"<cr>
    autocmd FileType c,cpp nnoremap <buffer> <silent> <Leader>eh :exe "e " . expand("%:r") . ".h"<cr>
augroup END
"}}}

" FileType: Javascript {{{
augroup filetype_javascript
    autocmd!
    autocmd FileType javascript let b:delimitMate_expand_cr = 1
    autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END
"}}}

" Filetype: RC {{{
augroup filetype_rc
    autocmd!
    autocmd FileType rc setlocal textwidth=0 noautoindent
    autocmd FileType rc setlocal tabstop=4 shiftwidth=4 expandtab
augroup END
"}}}

" Filetype: Python {{{
augroup filetype_python
    autocmd!
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    autocmd FileType python iabbrev <buffer> iff if:<left>
    autocmd FileType python iabbrev <buffer> eli elif:<left>
    autocmd FileType python iabbrev <buffer> imp import
    autocmd FileType python iabbrev <buffer> ret return()<left><c-r>=Eatchar('\s')<cr>
    autocmd FileType python iabbrev <buffer> return Use ret instead.
    autocmd FileType python iabbrev <buffer> if Use iff instead.
augroup END
"}}}

" Filetype: VIM {{{
augroup filetype_vim
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
    autocmd FileType vim setlocal tabstop=4 shiftwidth=4 expandtab
    autocmd FileType vim let b:surround_34 = "\"{{{ \r \"}}}"
augroup END
"}}}
"}}}
