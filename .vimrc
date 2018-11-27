"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Bundle (Vundle)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible        " required
filetype off            " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Plugins:

" Utility
Plugin 'a.vim'
Plugin 'taglist.vim'
Plugin 'ap/vim-css-color'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Syntax
Plugin 'godlygeek/tabular' " the tabular plugin must come before vim-markdown
Plugin 'plasticboy/vim-markdown'
" Colorscheme
Plugin 'morhetz/gruvbox'

" scripts on GitHub repos
"Plugin 'tpope/vim-rails.git'
" scripts from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" scripts not on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}
"
" All of your Plugins must be added before the following line
call vundle#end()               " required
filetype plugin indent on       " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList          - list configured plugins
" :PluginInstall(!)    - install (update) plugins
" :PluginSearch(!) foo - search (or refresh cache first) for foo
" :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin commands are not allowed.
" Put your stuff after this line


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
set tabstop=8 shiftwidth=8
set noexpandtab
autocmd FileType html,xml,xhtml set tabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml,json      set tabstop=2 shiftwidth=2 expandtab
autocmd FileType vim            set tabstop=4 shiftwidth=4 expandtab
autocmd FileType markdown       set tabstop=4 shiftwidth=4 expandtab
autocmd FileType tex,latex,bib  set tabstop=4 shiftwidth=4 expandtab
autocmd FileType python         set tabstop=4 shiftwidth=4 expandtab
autocmd FileType css,scss       set tabstop=4 shiftwidth=4
autocmd FileType haskell        set tabstop=4 shiftwidth=4

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='gruvbox'
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
nnoremap <F4> :! gdb -q %:r<CR>
nnoremap <F5> :! valgrind --leak-check=full ./%:r<CR>
nnoremap <F6> :! astyle --style=kr --indent=tab=8 --pad-oper --pad-comma
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
