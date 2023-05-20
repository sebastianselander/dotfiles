-- vim.cmd [[ au BufRead, BufNewFile *.agda call AgdaFileType() ]]

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = {"*.agda"},
    callback = function()
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', '<leader>al', '<cmd> CornelisLoad <CR>')
        vim.keymap.set('n', '<leader>al', '<cmd> CornelisLoad <CR>')
        vim.keymap.set('n', '<leader>a?', '<cmd> CornelisGoals <CR>')
        vim.keymap.set('n', '<leader>ax <C-f>', '<cmd> CornleisRestart <CR>')
        vim.keymap.set('n', '<leader>ax <C-a>', '<cmd> CornelisAbort <CR>')
        vim.keymap.set('n', '<leader>as', '<cmd> CornelisSolve <CR>')
        vim.keymap.set('n', '<leader>ab', '<cmd> CornelisPrevGoal <CR>')
        vim.keymap.set('n', '<leader>af', '<cmd> CornelisNextGoal <CR>')
        vim.keymap.set('n', '<leader>a <space>', '<cmd> CornelisGive <CR>')
        vim.keymap.set('n', '<leader>ar', '<cmd> CornelisRefine <CR>')
        vim.keymap.set('n', '<leader>am', '<cmd> CornelisElaborate <CR>')
        vim.keymap.set('n', '<leader>aa', '<cmd> CornelisAuto <CR>')
        vim.keymap.set('n', '<leader>ac', '<cmd> CornelisMakeCase <CR>')
        vim.keymap.set('n', '<leader>a,', '<cmd> CornelisTypeContext <CR>')
        vim.keymap.set('n', '<leader>ad', '<cmd> CornelisTypeInfer <CR>')
        vim.keymap.set('n', '<leader>a.', '<cmd> CornelisTypeContextInfer <CR>')
        vim.keymap.set('n', '<leader>an', '<cmd> CornelisNormalize <CR>')
        vim.keymap.set('n', '<leader>aw', '<cmd> CornelisWhyInScope <CR>')
        vim.keymap.set('n', '<leader>ah', '<cmd> CornelisHelperFunc <CR>')
        vim.keymap.set('n', 'gd', '<cmd> CornelisGoToDefinition <CR>')
    end
    })
