--
-- https://github.com/nvim-lualine/lualine.nvim
--

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        { 'rmagatti/auto-session', config = true },
    },
    config = function()
        local function session_name()
            return '[' .. require('auto-session.lib').current_session_name() .. ']'
        end

        require('lualine').setup({
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
                    session_name,
                    'branch',
                    'diff',
                    {
                        'diagnostics',
                        -- 'nvim_lsp', 'nvim_diagnostic',
                        -- 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
                        sources = { 'nvim_lsp', 'nvim_diagnostic', 'vim_lsp' },
                    },
                },
                lualine_c = {
                    {
                        'filename',
                        newfile_status = true,
                        path = 3,
                        symbols = {
                            modified = '◉ ',
                            readonly = '🔒',
                        }
                    },
                    {
                        'aerial',
                        sep = nil,       -- default separator
                        depth = -1,      -- the number of symbols to render
                        dense = false,   -- dense mode
                        dense_sep = '.', -- separator in dense mode
                        colored = true,  -- color the symbol icon
                    },
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
                lualine_c = {
                    {
                        'filename',
                        newfile_status = true,
                        path = 3,
                        symbols = {
                            modified = '◉ ',
                            readonly = '🔒',
                        }
                    },
                },
                lualine_x = {},
                lualine_y = {},
                lualine_z = { 'progress', '%l/%L %v' }
            },
        })
    end,
}
