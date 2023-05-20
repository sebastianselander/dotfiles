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
        vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
        vim.keymap.set('i', '<C-l>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>cf', function() vim.lsp.buf.format { async = true } end, bufopts)

        vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
        --
        -- autoformat only for haskell
        -- if vim.api.nvim_buf_get_option(0, 'filetype') == 'haskell' then
        --     vim.api.nvim_command[[
        --     autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
        -- end
    end
    ,
    settings = {
        haskell = {
            hlintOn = true,
            formattingProvider = "stylish-haskell"
        }
    }
})

nvim_lsp.rust_analyzer.setup({
    on_attach= function(client)
        local opts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, opts)
        vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, opts)
        vim.keymap.set('n', '<leader>cr', vim.lsp.buf.rename, opts)
        vim.keymap.set('i', '<C-l>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<space>cf', function() vim.lsp.buf.format { async = true } end, bufopts)

        vim.keymap.set('n', '<space>d', vim.diagnostic.open_float, opts)
    end
    ,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = {
                command = "clippy"
            },
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = true,
  }
)
