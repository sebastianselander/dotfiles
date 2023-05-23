require("toggleterm").setup {
    size = 12,
    direction = 'float', 
    open_mapping = [[<leader>0]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shading_factor = 0,
    autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
    start_in_insert = true,
    insert_mappings = false, -- absolutely never turn this shit on
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
    close_on_exit = true, -- close the terminal window when the process exits
    auto_scroll = false, -- automatically scroll to the bottom on terminal output
    border = 'double',
    -- This field is only relevant if direction is set to 'float'
    winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
            return term.name
        end
    },
}

vim.keymap.set('n', '<C-9>', vim.cmd.ToggleTermSendCurrentLine)
vim.keymap.set('n', '<leader>tv', ":ToggleTerm direction=vertical size=87 <CR>")
vim.keymap.set('n', '<leader>th', ":ToggleTerm direction=horizontal size=12 <CR>")
