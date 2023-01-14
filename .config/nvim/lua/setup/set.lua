vim.cmd.colorscheme "base16-gruber"

vim.opt.guicursor = ""
vim.opt.cursorline = true
vim.opt.mouse = ""

vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.hidden = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "auto"
vim.opt.isfname:append"@-@"

vim.opt.updatetime = 100

vim.opt.colorcolumn = "100"
vim.cmd('hi colorcolumn guibg=darkred')

vim.g.netrw_bufsettings = "noma nomod nu nowrap ro nobl"
