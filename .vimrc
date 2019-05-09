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
" Colorscheme
Plug 'morhetz/gruvbox'

call plug#end()

command! PU PlugUpdate | PlugUpgrade

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set shell=/bin/bash
set history=1000
filetype on
filetype plugin on
filetype indent on
set autoread
set autochdir
set tags=./tags;/
"set timeoutlen=0
"set ttimeoutlen=0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set scrolloff=5
set nu
set wrap
set wildmenu
set wildmode=longest:full,full
set ruler
set lazyredraw
set nostartofline
set incsearch
set hlsearch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors, Syntax and Encodings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set background=dark
colorscheme gruvbox
highlight SpellBad ctermbg=167 ctermfg=234
let c_syntax_for_h = 1
set encoding=utf8
set fileencodings=utf8,utf16,big5,gbk,latin1
set ffs=unix,dos,mac
nnoremap <S-u> :set fileencoding=utf-8<CR>:w<CR>
nnoremap <S-x> :set ff=unix<CR>:w<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set textwidth=80
set colorcolumn=81
set backspace=indent,eol,start
set pastetoggle=<F7>
set smarttab
set cindent
set autoindent
set smartindent
set modeline
set tabstop=4 shiftwidth=4 expandtab
autocmd FileType html,xml,xhtml set tabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml,json      set tabstop=2 shiftwidth=2 expandtab
autocmd FileType haskell        set tabstop=4 shiftwidth=4 noexpandtab
autocmd FileType c              set tabstop=8 shiftwidth=8 noexpandtab
autocmd BufWritePre * %s/\s\+$//e   " Automatically remove trailing ws before saving

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
let g:netrw_winsize = 25
let g:netrw_browse_split = 3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowritebackup
set noswapfile

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
