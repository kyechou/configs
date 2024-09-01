--
-- https://github.com/hrsh7th/nvim-cmp
-- `:help cmp`
--

return {
    'hrsh7th/nvim-cmp',
    dependencies = {
        -- Here we use LuaSnip as the snippet engine
        {
            'L3MON4D3/LuaSnip',
            build = (function() return 'make install_jsregexp' end)(),
        },
        'saadparwaiz1/cmp_luasnip', -- LuaSnip completion source for nvim-cmp
        -- LSP completion capabilities
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        -- Preconfigured snippets for different languages
        'rafamadriz/friendly-snippets',
    },
    config = function()
        local cmp = require('cmp')
        local luasnip = require('luasnip')
        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.setup()

        local custom_mapping = {
            ['<C-l>'] = cmp.mapping.complete({}),
            ['<CR>'] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }),
            ['<C-p>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.mapping.scroll_docs(-4)
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<C-n>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.mapping.scroll_docs(4)
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<C-j>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<C-k>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { 'i', 's' }),
        }

        local insert_mapping = cmp.mapping.preset.insert(custom_mapping)
        local cmdline_mapping = cmp.mapping.preset.cmdline(custom_mapping)

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = {
                completeopt = 'menuone,preview',
            },
            mapping = insert_mapping,
            sources = {
                { name = 'codeium' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' },
                { name = 'path' },
            },
        })

        -- Set configuration for specific filetype.
        ---@diagnostic disable-next-line: missing-fields
        cmp.setup.filetype('gitcommit', {
            mapping = insert_mapping,
            sources = cmp.config.sources({
                { name = 'buffer' },
            })
        })

        -- Use buffer source for `/` and `?`
        ---@diagnostic disable-next-line: missing-fields
        cmp.setup.cmdline('/', {
            mapping = cmdline_mapping,
            sources = { { name = 'buffer' } }
        })

        ---@diagnostic disable-next-line: missing-fields
        cmp.setup.cmdline('?', {
            mapping = cmdline_mapping,
            sources = { { name = 'buffer' } }
        })

        -- Use cmdline & path source for ':'
        ---@diagnostic disable-next-line: missing-fields
        cmp.setup.cmdline(':', {
            mapping = cmdline_mapping,
            sources = cmp.config.sources(
                { { name = 'path' } },
                { { name = 'cmdline' } }
            )
        })
    end,
}
