--
-- https://github.com/akinsho/bufferline.nvim
-- `:help bufferline.nvim`
--

return {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local bufferline = require('bufferline')
        bufferline.setup({
            options = {
                style_preset = bufferline.style_preset.minimal,
                mode = 'tabs',    -- 'buffers' | 'tabs'
                themable = true,  -- allows highlight groups to be overriden
                numbers = 'none', -- 'none' | 'ordinal' | 'buffer_id' | 'both'
                indicator = {
                    -- icon = '▎', -- this should be omitted if indicator style is not 'icon'
                    style = 'none', -- 'icon' | 'underline' | 'none'
                },
                buffer_close_icon = '󰅖',
                modified_icon = '●',
                close_icon = '',
                left_trunc_marker = '',
                right_trunc_marker = '',
                max_name_length = 18,
                max_prefix_length = 15,   -- prefix used when a buffer is de-duplicated
                truncate_names = true,    -- whether or not tab names should be truncated
                tab_size = 1,
                diagnostics = 'nvim_lsp', -- false | 'nvim_lsp' | 'coc'
                diagnostics_update_in_insert = false,
                offsets = {
                    {
                        filetype = 'NvimTree',
                        text = function() return vim.fn.getcwd() end,
                        highlight = 'Directory',
                        text_align = 'left', -- 'left' | 'center' | 'right'
                        separator = true,    -- true | '?'
                    }
                },
                color_icons = true, -- whether or not to add the filetype icon highlights
                show_buffer_icons = true,
                show_buffer_close_icons = false,
                show_close_icon = false,
                show_tab_indicators = false,
                show_duplicate_prefix = true, -- whether to show duplicate buffer prefix
                persist_buffer_sort = true,   -- whether custom sorted buffers should persist
                move_wraps_at_ends = false,   -- whether the move command "wraps" at the first or last position
                separator_style = { '', '' }, -- 'slant' | 'slope' | 'thick' | 'thin' | { 'any', 'any' }
                enforce_regular_tabs = false,
                always_show_bufferline = true,
            }
        })
    end,
}
