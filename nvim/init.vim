
"Plugins
call plug#begin()


Plug 'tpope/vim-commentary' " Easer commenting

Plug 'tpope/vim-surround' " (),{},[] etc made easier

Plug 'tpope/vim-fugitive' " Git easier

Plug 'junegunn/fzf' " Fuzzy finder
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'liuchengxu/vim-which-key'

Plug 'vim-airline/vim-airline' " Improved statusline
Plug 'vim-airline/vim-airline-themes' " Improved statusline

" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Starting screen 
Plug 'mhinz/vim-startify'

" Language-specific
Plug 'neovimhaskell/haskell-vim'

" Colors
Plug 'ayu-theme/ayu-vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'sainnhe/sonokai'
Plug 'morhetz/gruvbox'


call plug#end()

" use color theme
set termguicolors
colorscheme gruvbox

" nightfly
let g:nightflyCursorColor = 1
let g:nightflyItalics = 0
let g:nightflyUnderlineMatchParen = 1



"
" ----------------General Options---------------- 
"


" Syntax highlighting
syntax on

" Highlight current line
set cursorline

" Width of gutter
set numberwidth=5

set showtabline=1
set clipboard+=unnamedplus


" Specify color of line numbers
highlight LineNr ctermfg = Grey guifg=Grey


" Show certain whitespace as characters.
set list listchars=tab:\›\ ,trail:·,extends:>,precedes:<



" Show relative numbers of lines instead of the absolute numbers
set number relativenumber


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


"
" --------------Bindings--------------
"

" Remap leader key to space.
nnoremap <space> <Nop>
let mapleader = ' '

nnoremap <C-w>ä <C-w>>
nnoremap <C-w>ö <C-w><

" Bind Escape to clear current highlighting
nnoremap <silent> <esc> :noh<CR>

" Make escape also exit terminal mode
tnoremap <Esc> <C-\><C-n>

"
" -------------Plugin specific-------------
"


"
" WHICH KEY
"

" Set which key to show up when pressing leader key
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" By default timeoutlen is 1000 ms
set timeoutlen=500





"
"
" NERDTREE
"


" Toggle NERDTree panel
nnoremap <Leader>. :NERDTreeToggle<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Start NERDTree and put the cursor back in the other window.
autocmd VimEnter * NERDTree | wincmd p

" Start NERDTree on the right side
let g:NERDTreeWinPos = "right"

" Change default size of NERDTree
let g:NERDTreeWinSize=25

" Add git status changes in NERDTree
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
" Hide brackets around icons
let g:NERDTreeGitStatusConcealBrackets = 1 " default: 0

" Highlight files in NERDTree
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1


"
" Fuzzy finder
"


" Run fzf
nnoremap <Leader>, :FZF<CR>



"
" AIRLINE
"

let g:airline_theme='gruvbox'
