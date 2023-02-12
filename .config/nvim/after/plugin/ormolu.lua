vim.keymap.set('n', '<leader>tf', [[:call RunOrmolu()<CR>]] )
vim.g.ormolu_command = "fourmolu"
-- vim.g.ormolu_suppress_stderr = 1
-- vim.g.ormolu_options = "-o -XTypeApplications"
