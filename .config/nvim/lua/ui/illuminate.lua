--
-- https://github.com/RRethy/vim-illuminate
--

return {
    'RRethy/vim-illuminate',
    config = function()
        require('illuminate').configure({
            providers = {
                -- Ordered by priority
                'lsp',
                'treesitter',
                -- 'regex',
            },
            delay = 50, -- ms
            filetypes_denylist = {
                -- Filetypes to not illuminate
                'help',
                'NvimTree',
                'toggleterm',
                'dirbuf',
                'dirvish',
                'fugitive',
            },
            modes_allowlist = {
                -- :h mode()
                'n',                   -- normal mode
            },
            under_cursor = true,       -- whether or not to illuminate under cursor
            large_file_cutoff = 10000, -- number of lines
            case_insensitive_regex = false,
        })

        -- :h nvim_set_hl()
        local hl_value = {
            link = 'CursorLine',
        }
        vim.api.nvim_set_hl(0, 'IlluminatedWordRead', hl_value)
        vim.api.nvim_set_hl(0, 'IlluminatedWordText', hl_value)
        vim.api.nvim_set_hl(0, 'IlluminatedWordWrite', hl_value)
    end,
}
