"Plugins
call plug#begin()


Plug 'tpope/vim-commentary' " Easer commenting
Plug 'tpope/vim-surround' " (),{},[] etc made easier
Plug 'tpope/vim-fugitive' " Git easier

Plug 'preservim/nerdtree'

Plug 'itchyny/lightline.vim'

Plug 'neovimhaskell/haskell-vim'

" latexy boi
Plug 'lervag/vimtex'

" markdowny boi
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

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

" ----------------- LANGUAGE -------------------
" to enable highlighting of `forall`
let g:haskell_enable_quantification     = 1
" to enable highlighting of `mdo` and `rec`
let g:haskell_enable_recursivedo        = 1
" to enable highlighting of `proc`
let g:haskell_enable_arrowsyntax        = 1
" to enable highlighting of `pattern`
let g:haskell_enable_pattern_synonyms   = 1
" to enable highlighting of type roles
let g:haskell_enable_typeroles          = 1
" to enable highlighting of `static`
let g:haskell_enable_static_pointers    = 1
" to enable highlighting of backpack keywords
let g:haskell_backpack                  = 1


let g:haskell_indent_if                 = 2
let g:haskell_indent_case               = 2
let g:haskell_indent_let                = 4
let g:haskell_indent_where              = 2
let g:haskell_indent_before_where       = 2
let g:haskell_indent_after_bare_where   = 2
let g:haskell_indent_do                 = 2
let g:haskell_indent_in                 = 1
let g:haskell_indent_guard              = 2
let g:haskell_indent_case_alternative   = 1

" vimtex
let g:vimtex_view_method = 'zathura'

"
" ----------------General Options----------------
"

" Syntax highlighting
syntax on

filetype plugin indent on

" Color column 100
set colorcolumn=90

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

" clipboard copy
nnoremap <leader>y "+y
nnoremap <leader>p "+p
vnoremap <leader>y "+y
vnoremap <leader>p "+p

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
" autocmd BufWritePre * if !&binary | call TrimWhitespace() | endif

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

"
" MARKDOWN PREVIEW
"

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']
