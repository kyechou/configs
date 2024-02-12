--
-- Key mappings must be done after telescope is fully loaded. Otherwise they
-- willl be overwritten.
--
-- https://github.com/nvim-telescope/telescope.nvim
-- `:help telescope.setup()`
--

local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        mappings = {
            -- `:help telescope.mappings`
            -- `:help telescope.actions`
            i = {
                ['<C-/>'] = actions.which_key,               -- show key mappings
                ['<C-q>'] = actions.close,                   -- close telescope
                ['<C-x>'] = actions.delete_buffer,           -- delete selected buffer
                ['<C-j>'] = actions.move_selection_next,     -- move down
                ['<C-k>'] = actions.move_selection_previous, -- move up
                ['<C-n>'] = actions.preview_scrolling_down,  -- scroll down preview
                ['<C-p>'] = actions.preview_scrolling_up,    -- scroll up preview
                ['<C-d>'] = actions.results_scrolling_down,  -- scroll down
                ['<C-u>'] = actions.results_scrolling_up,    -- scroll up
                ['<CR>'] = actions.select_default,           -- open in current window
                ['<C-s>'] = actions.select_horizontal,       -- horizontal split
                ['<C-t>'] = actions.select_tab,              -- open in new tab
                ['<C-v>'] = actions.select_vertical,         -- vertical split
                ['<C-a>'] = actions.toggle_all,              -- toggle all selection
                ['<C-l>'] = false,
                ['<M-q>'] = false,
                ['<C-c>'] = false,
                ['<Down>'] = false,
                ['<Up>'] = false,
                ['<PageDown>'] = false,
                ['<PageUp>'] = false,
            },
            n = {
                ['?'] = actions.which_key,                  -- show key mappings
                ['<Esc>'] = actions.close,                  -- close telescope
                ['<C-q>'] = actions.close,                  -- close telescope
                ['q'] = actions.close,                      -- close telescope
                ['<C-x>'] = actions.delete_buffer,          -- delete selected buffer
                ['j'] = actions.move_selection_next,        -- move down
                ['k'] = actions.move_selection_previous,    -- move up
                ['G'] = actions.move_to_bottom,             -- move to bottom
                ['L'] = actions.move_to_bottom,             -- move to bottom
                ['M'] = actions.move_to_middle,             -- move to middle
                ['H'] = actions.move_to_top,                -- move to top
                ['gg'] = actions.move_to_top,               -- move to top
                ['<C-n>'] = actions.preview_scrolling_down, -- scroll down preview
                ['<C-p>'] = actions.preview_scrolling_up,   -- scroll up preview
                ['<C-d>'] = actions.results_scrolling_down, -- scroll down
                ['<C-u>'] = actions.results_scrolling_up,   -- scroll up
                ['<CR>'] = actions.select_default,          -- open in current window
                ['<C-s>'] = actions.select_horizontal,      -- horizontal split
                ['<C-t>'] = actions.select_tab,             -- open in new tab
                ['<C-v>'] = actions.select_vertical,        -- vertical split
                ['<M-q>'] = false,
                ['<Down>'] = false,
                ['<Up>'] = false,
                ['<PageDown>'] = false,
                ['<PageUp>'] = false,
            },
        },
    }
})
