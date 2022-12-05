"Plugins
call plug#begin()

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf'
Plug 'itchyny/lightline.vim'
Plug 'neovimhaskell/haskell-vim'
" moves cursor to top of file on save, super annoying
" Plug 'alx741/vim-hindent'
Plug 'lervag/vimtex'
Plug 'joom/latex-unicoder.vim'
Plug 'ayu-theme/ayu-vim'
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'sainnhe/sonokai'
Plug 'gruvbox-community/gruvbox'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Haskell plug and deps
Plug 'MrcJkb/haskell-tools.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

call plug#end()


" lua << LUA
" local ht = require('haskell-tools')
" local def_opts = { noremap = true, silent = true, }
" ht.setup {
"   hls = {
"     -- See nvim-lspconfig's  suggested configuration for keymaps, etc.
"     on_attach = function(client, bufnr)
"       local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
"       -- haskell-language-server relies heavily on codeLenses,
"       -- so auto-refresh (see advanced configuration) is enabled by default
"       vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
"       vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
"       -- default_on_attach(client, bufnr)  -- if defined, see nvim-lspconfig
"     end,
"   },
" }
" -- Suggested keymaps that do not depend on haskell-language-server
" -- Toggle a GHCi repl for the current package
" vim.keymap.set('n', '<leader>rr', ht.repl.toggle, def_opts)
" -- Toggle a GHCi repl for the current buffer
" vim.keymap.set('n', '<leader>rf', function()
"   ht.repl.toggle(vim.api.nvim_buf_get_name(0))
" end, def_opts)
" vim.keymap.set('n', '<leader>rq', ht.repl.quit, def_opts)
" LUA




""
"" ----------------THEME----------------
""

"" use color theme
set termguicolors
colorscheme ayu


"" terminal style cursor
set guicursor=n-v-c:block-Cursor

let g:haskell_enable_quantification   = 1
let g:haskell_enable_recursivedo      = 1
let g:haskell_enable_arrowsyntax      = 1
let g:haskell_enable_pattern_synonyms = 1
let g:haskell_enable_typeroles        = 1
let g:haskell_enable_static_pointers  = 1
let g:haskell_backpack                = 1


let g:haskell_indent_if               = 2
let g:haskell_indent_case             = 2
let g:haskell_indent_let              = 4
let g:haskell_indent_where            = 2
let g:haskell_indent_before_where     = 2
let g:haskell_indent_after_bare_where = 2
let g:haskell_indent_do               = 2
let g:haskell_indent_in               = 1
let g:haskell_indent_guard            = 2
let g:haskell_indent_case_alternative = 1



"" vimtex
let g:vimtex_view_method = 'zathura'

""
"" ----------------General Options----------------
""
" cool comment
syntax on
filetype plugin indent on

set colorcolumn=100
set cursorline
set modifiable
set nowrap
set noswapfile
set list listchars=tab:\›\ ,trail:·,extends:>,precedes:<
set nrformats-=octal
set number relativenumber
set termguicolors
set mouse=
set nu
set hidden
set splitright
set splitbelow
set softtabstop=0
set shiftwidth=0
set tabstop=4
set numberwidth=5
set scrolloff=8
set showtabline=1
set expandtab
set smarttab
set ignorecase
set smartcase
set spelllang=en,sv
set smartindent

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o formatoptions+=j formatoptions+=q


let mapleader = ' '
nnoremap <space> <Nop>
nnoremap <silent><leader>h :wincmd h<CR>
nnoremap <silent><leader>j :wincmd j<CR>
nnoremap <silent><leader>k :wincmd k<CR>
nnoremap <silent><leader>l :wincmd l<CR>
nnoremap <silent> <esc> :noh<CR>
nnoremap <silent><leader>y "+y
nnoremap <silent><leader>p "+p
nnoremap <silent><leader>gs :G<CR>
nnoremap <silent><leader>gh :diffget //2<CR>
nnoremap <silent><leader>gl :diffget //3<CR>
nnoremap <silent><leader>ff :FZF ~<CR>
nnoremap <silent><leader>fh :FZF<CR>
nnoremap <silent><leader><space> :so ~/.config/nvim/init.vim<CR>
nnoremap <silent><leader>sp :call FixLastSpellingError()<CR>
nnoremap <silent><leader>sw :call SwapWords()<CR>
nnoremap <silent><leader>ä :bnext<CR>
nnoremap <silent><leader>ö :bprevious<CR>
nnoremap <silent> <leader>af :Autoformat<CR>

vnoremap <silent><leader>y "+y
vnoremap <silent><leader>p "+p

tnoremap <Esc> <C-\><C-n>

command! CFG call EditConfig()<CR>
"
" FUNCTIONS
"

" Swap two following words, skipping all non-alphabetical words
function SwapWords()
    normal mmyee
    execute "normal /\\a\<cr>"
    normal Plde`mPlde`m
endfunction

function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

function FixLastSpellingError()
    :normal mm[s1z=`m
endfunction


function EditConfig()
    :tabe ~/.config/nvim/init.vim
endfunction


"
" LIGHTLINE
"

let g:lightline = {
            \ 'colorscheme': 'ayu',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'absolutepath', 'modified'] ]
            \ },
            \ }

" Regex align
command! -nargs=? -range Align <line1>,<line2>call AlignSection('<args>')
vnoremap <silent> <Leader>aa :Align<CR>
function! AlignSection(regex) range
    let extra = 1
    let sep = empty(a:regex) ? '=' : a:regex
    let maxpos = 0
    let section = getline(a:firstline, a:lastline)
    for line in section
        let pos = match(line, ' *'.sep)
        if maxpos < pos
            let maxpos = pos
        endif
    endfor
    call map(section, 'AlignLine(v:val, sep, maxpos, extra)')
    call setline(a:firstline, section)
endfunction

function! AlignLine(line, sep, maxpos, extra)
    let m = matchlist(a:line, '\(.\{-}\) \{-}\('.a:sep.'.*\)')
    if empty(m)
        return a:line
    endif
    let spaces = repeat(' ', a:maxpos - strlen(m[1]) + a:extra)
    return m[1] . spaces . m[2]
endfunction
