--
-- https://github.com/nvim-treesitter/nvim-treesitter
-- |:help nvim-treesitter|
--

return {
    'nvim-treesitter/nvim-treesitter',
    -- dependencies = {
    --     'nvim-treesitter/nvim-treesitter-textobjects',
    -- },
    build = ':TSUpdate',
    config = function()
        local helper = require('util.helper')
        require('nvim-treesitter.configs').setup({
            -- Language parsers to be installed, or 'all'
            -- ensure_installed = vim.tbl_keys(helper.ts_language_parsers),
            ensure_installed = helper.ts_language_parsers,
            -- Install languages synchronously (only applied to `ensure_installed`)
            sync_install = false,
            -- Auto-install missing parsers when entering buffer. Set to false
            -- if you don't have `tree-sitter` CLI installed.
            auto_install = false,
            -- List of parsers to ignore installing
            ignore_install = {},
            -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
            modules = {},
            highlight = { enable = true },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<c-space>',   -- 'gnn'
                    node_incremental = '<c-space>', -- 'grn'
                    scope_incremental = '<c-s>',    -- 'grc'
                    node_decremental = '<M-space>', -- 'grm'
                },
            },
            -- textobjects = {
            --     select = {
            --         enable = true,
            --         lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            --         keymaps = {
            --             -- You can use the capture groups defined in textobjects.scm
            --             ['aa'] = '@parameter.outer',
            --             ['ia'] = '@parameter.inner',
            --             ['af'] = '@function.outer',
            --             ['if'] = '@function.inner',
            --             ['ac'] = '@class.outer',
            --             ['ic'] = '@class.inner',
            --         },
            --     },
            --     move = {
            --         enable = true,
            --         set_jumps = true, -- whether to set jumps in the jumplist
            --         goto_next_start = {
            --             [']m'] = '@function.outer',
            --             [']]'] = '@class.outer',
            --         },
            --         goto_next_end = {
            --             [']M'] = '@function.outer',
            --             [']['] = '@class.outer',
            --         },
            --         goto_previous_start = {
            --             ['[m'] = '@function.outer',
            --             ['[['] = '@class.outer',
            --         },
            --         goto_previous_end = {
            --             ['[M'] = '@function.outer',
            --             ['[]'] = '@class.outer',
            --         },
            --     },
            --     swap = {
            --         enable = true,
            --         swap_next = {
            --             ['<leader>a'] = '@parameter.inner',
            --         },
            --         swap_previous = {
            --             ['<leader>A'] = '@parameter.inner',
            --         },
            --     },
            -- },
        })
    end,
}
