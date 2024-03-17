--
-- https://github.com/nvim-treesitter/nvim-treesitter
-- |:help nvim-treesitter|
--

-- TODO: Set up nvim-treesitter-textobjects
-- https://youtu.be/CEMPq_r8UYQ?si=AHcqeUFsOngXxdyK

return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPre', 'BufNewFile' },
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
            highlight = {
                enable = true,
                -- I don't like treesitter's bash highlighting
                disable = { 'latex', 'markdown', 'bash' },
                additional_vim_regex_highlighting = { 'latex', 'markdown' },
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<C-space>',
                    node_incremental = '<C-space>',
                    scope_incremental = false,
                    node_decremental = '<BS>',
                },
            },
        })
    end,
}
