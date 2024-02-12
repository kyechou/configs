--
-- https://github.com/lukas-reineke/indent-blankline.nvim
-- `:help ibl` `:help ibl.config`
--

return {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
        scope = {
            -- `:help idl.config.scope.exclude`
            exclude = {
                language = {}, -- Requires treesitter
            },
        },
    },
}
