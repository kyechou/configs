--
-- https://github.com/nvim-lualine/lualine.nvim
--

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = '',
            section_separators = '',
            globalstatus = false,
        },
        sections = {
            lualine_a = { 'mode' },
            lualine_b = {
                'hostname',
                'branch',
                'diff',
                {
                    'diagnostics',
                    -- 'nvim_lsp', 'nvim_diagnostic',
                    -- 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
                    sources = { 'nvim_lsp', 'nvim_diagnostic', 'coc' },
                }
            },
            lualine_c = {
                {
                    'filename',
                    newfile_status = true,
                    path = 3,
                    symbols = {
                        modified = '+',
                        readonly = '🔒',
                    }
                }
            },
            lualine_x = {
                {
                    'datetime',
                    style = '%H:%M'
                },
            },
            lualine_y = {
                'filetype',
                'fileformat',
                'encoding',
            },
            lualine_z = { 'progress', '%l/%L %v' }
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { 'filename' },
            lualine_x = {},
            lualine_y = {},
            lualine_z = { 'progress', '%l/%L %v' }
        },
    },
}
