local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup { pickers = { buffers = { initial_mode = "normal" } } }

vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function() builtin.grep_string({search = vim.fn.input("Grep > ")}) end)
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
