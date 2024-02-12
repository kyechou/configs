--
-- https://github.com/numToStr/Comment.nvim
--

return {
    'numToStr/Comment.nvim',
    config = true, -- This should run the setup function upon loading.
    opts = {
        -- Toggle mappings in NORMAL mode
        toggler = {
            line = '<C-/>', -- Default: 'gcc'
            block = 'gbc',  -- Default: 'gbc'
        },
        -- Operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
            line = '<C-c>', -- Default: 'gc'
            block = 'gb',   -- Default: 'gb'
        },
        -- Extra mappings
        extra = {
            above = '<C-c>O', -- Default: 'gcO'
            below = '<C-c>o', -- Default: 'gco'
            eol = '<C-c>A',   -- Default: 'gcA'
        },
    },
}
