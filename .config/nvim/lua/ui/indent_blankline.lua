--
-- https://github.com/lukas-reineke/indent-blankline.nvim
-- `:help ibl` `:help ibl.config`
--

return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
        indent = {
            char = '▏',
        },
        scope = {
            show_start = false,
            show_end = false,
            exclude = {
                -- `:help idl.config.scope.exclude`
                language = {
                    'markdown', 'tex', 'json', 'jsonc'
                }, -- Requires treesitter
            },
        },
    },
}
