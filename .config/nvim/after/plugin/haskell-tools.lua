local ht = require('haskell-tools')
local def_opts = { noremap = true, silent = true, }
ht.setup {
    hls = {
        on_attach = function(client, bufnr)
            local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
            -- haskell-language-server relies heavily on codeLenses,
            -- so auto-refresh (see advanced configuration) is enabled by default
            vim.keymap.set('n', '<space>la', vim.lsp.codelens.run, opts)
            vim.keymap.set('n', '<space>ls', ht.hoogle.hoogle_signature, opts)
            -- default_on_attach(client, bufnr)  -- if defined, see nvim-lspconfig
        end,
    },
}
