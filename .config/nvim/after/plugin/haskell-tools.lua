local ht = require('haskell-tools')
local def_opts = { noremap = true, silent = true }
ht.setup {
    tools = {
        repl = {
            handler = 'toggleterm',
            auto_focus = false,
        },
        definition = {
            hoogle_signature_fallback = true,
        },
    },
    hls = {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr })
            keymap.set('n', '<leader>hs', ht.hoogle.hoogle_signature, opts)
            keymap.set('n', '<leader>tg', telescope.extensions.ht.package_grep, opts)
            keymap.set('n', '<leader>th', telescope.extensions.ht.package_hsgrep, opts)
            keymap.set('n', '<leader>tf', telescope.extensions.ht.package_files, opts)
            keymap.set('n', '<leader>hp', ht.project.open_package_yaml, opts)
        end,
        settings = {
            haskell = {
                formattingProvider = 'fourmolu',
                maxCompletions = 10,
            },
        },
    },
}
