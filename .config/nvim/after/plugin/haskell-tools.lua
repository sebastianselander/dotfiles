local ht = require('haskell-tools')
local def_opts = { noremap = true, silent = true, }
ht.setup {
    hls = {
        on_attach = function(client, bufnr)
            local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
            -- haskell-language-server relies heavily on codeLenses,
            -- so auto-refresh (see advanced configuration) is enabled by default
            vim.keymap.set('n', '<leader>ca', vim.lsp.codelens.run, opts)
            -- TODO: Figure out how to use the code snippet evaluator from HLS
            -- default_on_attach(client, bufnr)  -- if defined, see nvim-lspconfig
        end,
    },
}
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>rr', ht.repl.toggle, def_opts)
-- Disable GHCi repl
vim.keymap.set('n', '<leader>rq', ht.repl.quit, def_opts)
