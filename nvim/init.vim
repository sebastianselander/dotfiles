"Plugins
call plug#begin()


Plug 'tpope/vim-commentary' " Easer commenting
Plug 'tpope/vim-surround' " (),{},[] etc made easier
Plug 'tpope/vim-fugitive' " Git easier

Plug 'preservim/nerdtree'

Plug 'itchyny/lightline.vim'

Plug 'neovimhaskell/haskell-vim'

" schemes
Plug 'ayu-theme/ayu-vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'sainnhe/sonokai'
Plug 'morhetz/gruvbox'

call plug#end()

"
" ----------------THEME----------------
"

" use color theme
set termguicolors
colorscheme nightfly

" nightfly
let g:nightflycursorcolor=1
let g:nightflyitalics=0
let g:nightflyunderlinematchparen=1



" terminal style cursor
set guicursor=n-v-c:block-Cursor

"
" ----------------General Options----------------
"

" Syntax highlighting
syntax on

" Color column 100
set colorcolumn=80

" Highlight current line
set cursorline

" Width of gutter
set numberwidth=5

set scrolloff=1

set showtabline=1
" set clipboard+=unnamedplus

" Specify color of line numbers
highlight LineNr ctermfg=Grey guifg=Grey

set modifiable
set nowrap

" Show certain whitespace as characters.
set list listchars=tab:\›\ ,trail:·,extends:>,precedes:<

set nrformats-=octal

" Show relative numbers of lines instead of the absolute numbers
set number relativenumber

" Make vsplit open to the right.
set splitright

" Make split open below
set splitbelow

" Tab/space insertion. By default, insert 4 spaces instead of a TAB character.
set softtabstop=0  " Don't do fancy conversion from spaces -> tab
set expandtab      " Use spaces instead of tabs
set shiftwidth=4   " How many spaces should be inserted when pressing tab
set smarttab

" Turn off automatic formatting, except for removal of comment leaders when
" appropriate. Do this for all languages
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o formatoptions+=j formatoptions+=q

" Use smartcase search by default (case-sensitive if pattern contains
" upper-case letters, case-insensitive otherwise. Include the '\C' escape
" sequence anywhere in the pattern to override and use case-sensitive search.
" Note that smartcase only activates if ignorecase is already active.
set ignorecase
set smartcase

" spell checking
set spelllang=en,sv

" fuzzy finding
set path+=.,,**
set wildmenu
set wildignore+=.git


"
" --------------Bindings--------------
"

" Remap leader key to space.
nnoremap <space> <Nop>
let mapleader = ' '

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Bind Escape to clear current highlighting
nnoremap <silent> <esc> :noh<CR>

" Make escape also exit terminal mode
tnoremap <Esc> <C-\><C-n>

nnoremap <leader>gs :G<CR>
nnoremap <leader>gh :diffget //2<CR>
nnoremap <leader>gl :diffget //3<CR>

nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader><space> :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>sp :call FixLastSpellingError()<CR>
nnoremap <leader>sw :call SwapWords()<CR>
nnoremap <leader>te :call OpenTerminalVSplit()<CR>
nnoremap <leader>ä :bnext<CR>
nnoremap <leader>ö :bprevious<CR>


"
" FUNCTIONS
"
function OpenTerminalVSplit()
    :65vsplit
    normal <C-w>w
    :term
endfunction

" Swap two following words, skipping all non-alphabetical words
function SwapWords()
    normal mmyee
    execute "normal /\\a\<cr>"
    normal Plde`mPlde`m
endfunction

function TrimWhitespace()
  %s/\(^--\)\@<!\s*$//
  ''
endfunction

function FixLastSpellingError()
    :normal mm[s1z=`m
endfunction

" Automatically trim trailing whitespace on save.
autocmd BufWritePre * if !&binary | call TrimWhitespace() | endif

"
" NERDTREE
"

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Start NERDTree on the right side
let g:NERDTreeWinPos = "right"

" Change default size of NERDTree
let g:NERDTreeWinSize=35


"
" LIGHTLINE
"

let g:lightline = {
      \ 'colorscheme': 'ayu_mirage',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'absolutepath', 'modified'] ]
      \ },
      \ }
