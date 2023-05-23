local telescope = require('telescope')
local builtin = require('telescope.builtin')

telescope.setup {
    pickers = {
        buffers = {
            initial_mode = "normal",
            sort_mru = true,
            ignore_current_buffer = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
                n = {
                    ["dd"] = "delete_buffer"
                }
            }
        },
        colorscheme = {
            initial_mode = "normal"
        }
    }
}

local nnoremap = function(lhs, rhs)
    vim.keymap.set('n', lhs, rhs, { noremap = true })
end

nnoremap('<leader>pp', builtin.find_files)
nnoremap('<C-p>', builtin.git_files)
nnoremap('<leader>ps', function() builtin.grep_string({search = vim.fn.input("Grep > ")}) end)
nnoremap('<leader>b', builtin.buffers)
nnoremap('<leader>pc', builtin.commands)
nnoremap('<leader>pr', builtin.registers)
nnoremap('<leader><F1>', builtin.colorscheme)
