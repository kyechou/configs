"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Plugins (vim-plug)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin()

" Utility
Plug 'itchyny/lightline.vim'
Plug 'Yggdroot/indentLine'
Plug 'ap/vim-css-color'
Plug 'mileszs/ack.vim'
Plug 'craigemery/vim-autotag'
Plug 'vim-scripts/taglist.vim'
Plug 'vim-scripts/a.vim', {'for': ['c', 'cpp']}
Plug 'MarcWeber/vim-addon-local-vimrc'
" Syntax
Plug 'godlygeek/tabular', {'for': 'markdown'} " needed by vim-markdown
Plug 'plasticboy/vim-markdown', {'for': 'markdown'}
Plug 'cespare/vim-toml', {'for': 'toml'}
Plug 'blyoa/vim-promela-syntax', {'for': 'promela'}
Plug 'vim-scripts/maude.vim', {'for': 'maude'}
Plug 'vim-scripts/click.vim', {'for': 'click'}
Plug 'rightson/vim-p4-syntax', {'for': 'p4'}
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
set nojoinspaces  " 1 space after '.', '?', '!'
set noswapfile
set tabpagemax=30
set tags=./tags;
set viminfo=""
set viminfofile="NONE"
set diffopt+=internal,algorithm:patience
set sessionoptions=blank,buffers,curdir,folds,help,options,slash,tabpages,unix

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start
set colorcolumn=81
set guicursor=a:block
set laststatus=2
set nocompatible
set nocursorline
set nolangremap
set noshowmode
set nostartofline
set number
set pastetoggle=<C-@>p
set ruler
set scrolloff=5
set showtabline=2
set sidescroll=1
set textwidth=0 " 80
set title
set ttyfast
set wildmenu
set wildmode=longest:full,full
set wrap
set nolinebreak

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Search
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set hlsearch
set incsearch
set ignorecase
set smartcase

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors, syntax and encodings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
set background=dark
colorscheme gruvbox
highlight Normal guibg=NONE ctermbg=NONE
highlight SpellBad ctermbg=167 ctermfg=234
let c_syntax_for_h = 1
set encoding=utf-8
set fileencodings=utf-8,big5,gbk,utf16,utf-16le,latin1
set ffs=unix,dos,mac
autocmd BufNewFile,BufRead *.h      set syntax=cpp filetype=cpp
autocmd BufNewFile,BufRead *.maude  set syntax=maude filetype=maude
autocmd BufNewFile,BufRead *.click  set syntax=click filetype=click

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tab and indentation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoindent
set cindent
set smartindent
set smarttab
set tabstop=4 shiftwidth=4 expandtab
autocmd FileType html,xml,xhtml set tabstop=2 shiftwidth=2 expandtab
autocmd FileType javascript     set tabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml,json      set tabstop=2 shiftwidth=2 expandtab
autocmd FileType haskell        set tabstop=4 shiftwidth=4 noexpandtab
autocmd BufWritePre * %s/\s\+$//e   " Remove trailing ws before saving

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => plasticboy/vim-markdown
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_math = 1
let g:vim_markdown_no_default_key_mappings = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
    \   'colorscheme': 'gruvbox',
    \   'active': {
    \       'left': [
    \           ['mode', 'paste', 'spell'],
    \           ['readonly', 'filename', 'modified']
    \       ],
    \   },
    \   'inactive': {
    \       'left': [['readonly', 'filename', 'modified']],
    \   },
    \   'component': {
    \       'readonly': '%r',
    \       'spell': 'SPELL [%{&spell?&spelllang:""}]',
    \   },
    \   'component_function': {
    \       'filename': 'LightlineFilename',
    \   },
    \   'tab': {
    \       'active': ['filename', 'modified'],
    \       'inactive': ['filename', 'modified'],
    \   },
    \   'tab_component_function': {
    \       'modified': 'LightlineTabModified',
    \   },
    \   'tabline': {
    \       'right': [],
    \   },
    \ }
function! LightlineFilename()
    return expand('%:~') ==# '' ? '[No Name]' :
        \ expand('%:~') ==# expand('%:t') ? expand('%:p') : expand('%:~')
endfunction
function! LightlineTabModified(n)
    let l:window_number = tabpagewinnr(a:n, '$')
    let l:modified = v:false
    let l:unmodifiable = v:false
    for winnr in range(1, l:window_number)
        let l:modified = l:modified || gettabwinvar(a:n, winnr, '&modified')
        let l:unmodifiable = l:unmodifiable ||
            \ !gettabwinvar(a:n, winnr, '&modifiable')
    endfor
    let l:string  = l:modified ? '+' : ''
    let l:string .= l:unmodifiable ? '-' : ''
    return l:string
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Yggdroot/indentLine
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:indentLine_char = '│' " '┆', '┊', '│', '▏'
let g:indentLine_fileTypeExclude = ['markdown', 'yaml', 'json', 'toml', "tex"]
"let g:indentLine_setConceal = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => netrw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_browse_split = 3

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ack.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => a.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType cpp let g:alternateExtensions_cpp = 'h,H,hpp,HPP'
autocmd FileType cpp let g:alternateExtensions_CPP = 'H,h,HPP,hpp'
let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../../src,sfr:../include,sfr:../include/veriflow,sfr:../inc'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Commands mapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <silent> 0 g0
nnoremap <silent> $ g$
noremap <C-@>y "+y
nnoremap <C-@>n :Lexplore<CR>
nnoremap <C-@>t :TlistToggle<CR>
nnoremap <C-@>s :set spell!<CR>
nnoremap <C-a> :A<CR>
nnoremap <C-s> :Ack!<Space>
nnoremap r :!<Space>
nnoremap t :tabnew<CR>
nnoremap yt :tab split<CR>
nnoremap <C-e> :tab drop<Space>
nnoremap <C-k> :tabclose<CR>
nnoremap <C-l> :tabnext<CR>
nnoremap <C-h> :tabprev<CR>
nnoremap <C-Right> :tabmove +1<CR>
nnoremap <C-Left> :tabmove -1<CR>
nnoremap <C-n> :noh<CR>
nnoremap <C-j> :edit!<CR>
nnoremap <C-@><C-i> :term<CR>
