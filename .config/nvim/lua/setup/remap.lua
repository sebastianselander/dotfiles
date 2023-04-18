vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

vim.keymap.set('n', '<space>', '<Nop>')
vim.keymap.set('n', '<esc>', vim.cmd.noh)
vim.keymap.set('n', 'J', 'mzJ`zdmz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'Y', 'yg$')

-- Tabs.
vim.keymap.set('n', '<leader>1', '1gt')
vim.keymap.set('n', '<leader>2', '2gt')
vim.keymap.set('n', '<leader>3', '3gt')
vim.keymap.set('n', '<leader>4', '4gt')
vim.keymap.set('n', '<leader>5', '5gt')
vim.keymap.set('n', '<leader>6', '6gt')
vim.keymap.set('n', '<leader>7', '7gt')
vim.keymap.set('n', '<leader>8', '8gt')
vim.keymap.set('n', '<leader>9', '9gt')

vim.keymap.set('n', '<leader>tn', '<cmd> tabnew % <CR> <cmd> tabm <CR>')
vim.keymap.set('n', '<leader>tm', '<cmd> tabm 0 <CR>')

vim.keymap.set('t', '<Esc>', "<C-\\><C-n>")

-- Change working directory
vim.keymap.set('n', '<leader>cd', '<cmd> cd %:h <CR>')

-- Windows.
vim.keymap.set('n', '<A-l>', '<C-w>l')
vim.keymap.set('n', '<A-h>', '<C-w>h')
vim.keymap.set('n', '<A-k>', '<C-w>k')
vim.keymap.set('n', '<A-j>', '<C-w>j')

-- Nice
vim.keymap.set('x', '<leader>p', '\"_dP')

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<leader>s', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
