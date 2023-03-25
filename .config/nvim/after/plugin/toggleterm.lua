require("toggleterm").setup {
    size = 20,
    direction = 'horizontal', 
    open_mapping = [[<C-0>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shading_factor = -10,
    autochdir = true, -- when neovim changes it current directory the terminal will change it's own when next it's opened
    start_in_insert = true,
    insert_mappings = true,
    terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
    persist_size = true,
    persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
    close_on_exit = true, -- close the terminal window when the process exits
    auto_scroll = true, -- automatically scroll to the bottom on terminal output
    border = 'double',
    -- This field is only relevant if direction is set to 'float'
    winbar = {
        enabled = false,
        name_formatter = function(term) --  term: Terminal
            return term.name
        end
    },
}

vim.keymap.set('n', '<leader>cc', vim.cmd.ToggleTermSendCurrentLine)

vim.keymap.set('n', '<leader>gs', '<cmd> 2TermExec direction=float cmd=\"lazygit\" <CR>')
