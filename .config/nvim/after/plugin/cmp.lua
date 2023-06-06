local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args)
            -- Requires `luasnip` and `cmp_luasnip` to have been installed.
            require('luasnip').lsp_expand(args.body)
        end,
    },

    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.scroll_docs(-4),
        ['<C-n>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),

        -- Best bindings
        ['<C-k>'] = cmp.mapping(function(fallback)
            cmp.select_prev_item()
        end),
        ['<C-j>'] = cmp.mapping(function(fallback)
            cmp.select_next_item()
        end),

        -- Accept currently selected item. Set `select` to `false` to only
        -- confirm explicitly selected items.
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
    }),

    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
        },
        {
            { name = 'buffer', keyword_length = 5 },
        }
    ),

    experimental = {
        ghost_text = {
            hl_group = 'LspCodeLens',
        }
    }
})

