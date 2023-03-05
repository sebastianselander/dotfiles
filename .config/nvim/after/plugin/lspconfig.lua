local nvim_lsp = require('lspconfig')

nvim_lsp.hls.setup({
    on_attach = function(client, bufnr)

        -- Mappings
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
        vim.keymap.set('i', '<C-l>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>cf', function() vim.lsp.buf.format { async = true } end, bufopts)
        
        vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
        --
        -- autoformat only for haskell
        if vim.api.nvim_buf_get_option(0, 'filetype') == 'haskell' then
            vim.api.nvim_command[[
            autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
        end
    end
    ,
    settings = {
        haskell = {
            hlintOn = true,
            formattingProvider = "fourmolu"
        }
    }
})

-- Only update diagnostics on BufWrite (:w)
-- vim.diagnostic.config({
--     virtual_text = false,
--     signs = false,
--     underline = false,
-- })

-- local ns = vim.api.nvim_create_namespace("my_test_namespace")

-- function show_diagnostics(bufnr)
--     local diags = vim.diagnostic.get(bufnr)
--     vim.diagnostic.show(ns, bufnr, diags, {
--         virtual_text = true,
--         signs = true,
--         underline = true,
--     })
-- end

-- vim.cmd [[
-- augroup test
--     autocmd!
--     autocmd BufWritePost * lua show_diagnostics(tonumber(vim.fn.expand("<abuf>")))
-- augroup END
-- ]]
