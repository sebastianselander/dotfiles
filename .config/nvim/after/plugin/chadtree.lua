local chadtree_settings = {
    view = {
        window_options = {
                cursorline = true,
                number = true,
                relativenumber = true,
                signcolumn = "no",
                winfixwidth = true,
                wrap = false
        }
    }
}

-- vim.keymap.set('n', '<leader>pv', vim.cmd.CHADopen)

vim.api.nvim_set_var("chadtree_settings", chadtree_settings)

-- Autostart CHADtree on opening a directory
-- vim.cmd(

-- [[
-- autocmd StdinReadPre * let s:std_in=1
-- autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
--     \ execute 'CHADopen' | execute 'cd '.argv()[0] | endif
-- ]]
-- )
