"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Plugins (vim-plug)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

" Utility
Plug 'vim-scripts/taglist.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/goyo.vim'
Plug 'vim-scripts/a.vim', { 'for': ['c', 'cpp'] }
Plug 'ap/vim-css-color', { 'for': ['css', 'scss'] }
" Syntax
Plug 'godlygeek/tabular', { 'for': 'markdown' } " needed by vim-markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'vim-scripts/promela.vim', { 'for': 'promela' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
" Colorscheme
Plug 'morhetz/gruvbox'

call plug#end()

command! PU PlugUpdate | PlugUpgrade

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype on
filetype plugin on
filetype indent on
set autochdir
set autoread
set belloff=all
set history=1000
set modeline
set nobackup
set noswapfile
set tabpagemax=30
set tags=./tags;/
set viminfo=""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start
set guicursor=a:block
set hlsearch
set incsearch
set laststatus=2
set nocompatible
set nolangremap
set nostartofline
set number
set pastetoggle=<F7>
set ruler
set scrolloff=5
set sidescroll=1
set textwidth=80
set colorcolumn=81
set ttyfast
set wildmenu
set wildmode=longest:full,full
set wrap

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors, syntax and encodings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set background=dark
colorscheme gruvbox
highlight SpellBad ctermbg=167 ctermfg=234
let c_syntax_for_h = 1
set encoding=utf8
set fileencodings=utf8,latin1,utf16,big5,gbk
set ffs=unix,dos,mac
nnoremap <S-u> :set fileencoding=utf-8<CR>:w<CR>
nnoremap <S-x> :set ff=unix<CR>:w<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tab and indentation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set cindent
set smartindent
set smarttab
set tabstop=4 shiftwidth=4 expandtab
autocmd FileType html,xml,xhtml set tabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml,json      set tabstop=2 shiftwidth=2 expandtab
autocmd FileType haskell        set tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType c              set tabstop=8 shiftwidth=8 noexpandtab
autocmd BufWritePre * %s/\s\+$//e   " Remove trailing ws before saving

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => a.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType cpp let g:alternateExtensions_cpp = "hpp,HPP,h,H"
autocmd FileType cpp let g:alternateExtensions_CPP = "HPP,hpp,H,h"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline_symbols = {}
let g:airline_symbols.whitespace = '!'
let g:airline_symbols.linenr = ''
let g:airline_symbols.crypt = 'cr'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => plasticboy/vim-markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => netrw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_browse_split = 3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F2> :Lex<CR>
nnoremap <F3> :TlistToggle<CR>
nnoremap <F4> :Goyo<CR>
nnoremap <F5> :! astyle --style=kr --indent=tab=8 --pad-oper --pad-comma
                 \ --pad-header --align-pointer=name --suffix=none %<CR>
nnoremap <F10> :set spell!<CR>
nnoremap r :!<Space>
nnoremap <C-a> :A<CR>
nnoremap <C-e> :tabedit<Space>
nnoremap <C-k> :tabclose<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprev<CR>
nnoremap <C-n> :noh<CR>
nnoremap <C-j> :edit!<CR>
" autocmd: comment
autocmd FileType c       nnoremap <F9> I/*<esc>A*/<esc>j
autocmd FileType c       nnoremap <F8> ^2x$xxj
autocmd FileType c       nnoremap <S-F9> I/*<esc>A*/<esc>k
autocmd FileType c       nnoremap <S-F8> ^2x$xxk
autocmd FileType asm     nnoremap <F9> I#<esc>j
autocmd FileType asm     nnoremap <F8> ^xj
autocmd FileType asm     nnoremap <S-F9> I#<esc>k
autocmd FileType asm     nnoremap <S-F8> ^xk
autocmd FileType cpp     nnoremap <F9> I/*<esc>A*/<esc>j
autocmd FileType cpp     nnoremap <F8> ^2x$xxj
autocmd FileType cpp     nnoremap <S-F9> I/*<esc>A*/<esc>k
autocmd FileType cpp     nnoremap <S-F8> ^2x$xxk
autocmd FileType vim     nnoremap <F9> I"<esc>j
autocmd FileType vim     nnoremap <F8> ^xj
autocmd FileType vim     nnoremap <S-F9> I"<esc>k
autocmd FileType vim     nnoremap <S-F8> ^xk
autocmd FileType sh      nnoremap <F9> I#<esc>j
autocmd FileType sh      nnoremap <F8> ^xj
autocmd FileType sh      nnoremap <S-F9> I#<esc>k
autocmd FileType sh      nnoremap <S-F8> ^xk
autocmd FileType python  nnoremap <F9> I#<esc>j
autocmd FileType python  nnoremap <F8> ^xj
autocmd FileType python  nnoremap <S-F9> I#<esc>k
autocmd FileType python  nnoremap <S-F8> ^xk
autocmd FileType haskell nnoremap <F9> I--<esc>jh
autocmd FileType haskell nnoremap <F8> ^2xj
autocmd FileType haskell nnoremap <S-F9> I--<esc>kh
autocmd FileType haskell nnoremap <S-F8> ^2xk
" autocmd: compile
autocmd FileType c       nnoremap <C-c> :! gcc % -o %:r -Wall -Wextra -Wpedantic
                                           \ -Werror -O3 -std=c11<CR>
autocmd FileType cpp     nnoremap <C-c> :! g++ % -o %:r -Wall -Wextra -Wpedantic
                                           \ -Werror -O3 -std=c++14<CR>
" autocmd: execute
autocmd FileType c       nnoremap <C-x> :! ./%:r<CR>
autocmd FileType cpp     nnoremap <C-x> :! ./%:r<CR>
