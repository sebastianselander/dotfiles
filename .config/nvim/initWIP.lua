
local paq = require('paq-nvim').paq
local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local opt = vim.opt

paq {'tpope/vim-commentary'}
paq {'tpope/vim-surround'}
paq {'tpope/vim-fugitive'}
paq {'junegunn/fzf'}
paq {'itchyny/lightline.vim'}
paq {'neovimhaskell/haskell-vim'}
-- moves cursor to top of file on save, super annoying
-- paq {'alx741/vim-hindent'}
paq {'lervag/vimtex'}
paq {'joom/latex-unicoder.vim'}
paq {'ayu-theme/ayu-vim'}
paq {'bluz71/vim-nightfly-guicolors'}
paq {'sainnhe/sonokai'}
paq {'MrcJkb/haskell-tools.nvim'}
paq {'neovim/nvim-lspconfig'}
paq {'nvim-lua/plenary.nvim'}
paq {'nvim-telescope/telescope.nvim'}

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

opt.colorcolum=100
opt.cursorline = true
opt.expandtab = true
opt.hidden = true
opt.ignorecase = true
opt.joinspaces = true
opt.list = true
opt.number = true
opt.relativenumber = true
opt.scrolloff = 8
opt.shiftround = true
opt.shiftwidth = 2
opt.sidescrolloff = 8
opt.smartcase = true
opt.smartindent = true
opt.splitbelow = true
opt.splitright = true
opt.tabstop = 2
opt.termguicolors = true
opt.wildmode = { 'list', 'longest' }
opt.wrap = false

map('n', '<silent><leader>h', ':windcmd h<CR>')
map('n', '<silent><leader>j', ':windcmd j<CR>')
map('n', '<silent><leader>k', ':windcmd k<CR>')
map('n', '<silent><leader>l', ':windcmd l<CR>')
map('n', '<esc>', ':noh<CR>')
map('n', '<silent><leader>y', '"+y')
map('n', '<silent><space>', 'Nop')
map('n', '<silent><leader>p', '"+p')
map('n', '<silent><leader>gs', ':G<CR>')
map('n', '<silent><leader>gh', ':diffget //2<CR>')
map('n', '<silent><leader>gl', ':diffget //3<CR>')
map('n', '<silent><leader>ff', ':FZF ~<CR>')
map('n', '<silent><leader>fh', ':FZF<CR>')
map('n', '<silent><leader><space>' ':so ~/.config/nvim/init.vim<CR>')
map('n', '<silent><leader>sp', ':call FixLastSpellingError()<CR>')
map('n', '<silent><leader>sw', ':call SwapWords()<CR>')
map('n', '<silent><leader>ä', ':bnext<CR>')
map('n', '<silent><leader>ö', ':bprevious<CR>')
map('n', '<silent> <leader>af', ':Autoformat<CR>')

map('v', '<silent><leader>y', '"+y')
map('v', '<silent><leader>p', '"+p')

map('t', '<Esc>', '<C-\><C-n>')

-- Utilities

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


