--
-- https://github.com/lervag/vimtex
-- https://github.com/barreiroleo/ltex_extra.nvim
--

return {
    'lervag/vimtex',
    dependencies = {
        {
            'barreiroleo/ltex-extra.nvim',       -- Client integration of ltex-ls (needed for dictionaries)
            dependencies = {
                'neovim/nvim-lspconfig',         -- LSP configuration
                'hrsh7th/cmp-nvim-lsp',          -- LSP completion capabilities
                'folke/neodev.nvim',             -- Full signature and completion for nvim Lua
                'lukas-reineke/lsp-format.nvim', -- Use the native LSP formatting
            },
            ft = { 'bib', 'plaintex', 'tex', 'context' },
            config = function()
                -- Apply cmp-nvim-lsp for additional completion capabilities
                local capabilities = vim.lsp.protocol.make_client_capabilities()
                capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

                -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
                require("neodev").setup()

                local helper = require('util.helper')
                require('ltex_extra').setup({
                    -- table <string> : languages for witch dictionaries will be loaded
                    load_langs = { 'en-US' },
                    -- boolean : whether to load dictionaries on startup
                    init_check = true,
                    -- string : relative or absolute path to store dictionaries
                    -- e.g. subfolder in the project root or the current working directory: ".ltex"
                    -- e.g. shared files for all projects:  vim.fn.expand("~") .. "/.local/share/ltex"
                    path = '.ltex',
                    -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
                    log_level = 'none',
                    -- table : configurations of the ltex language server.
                    -- Only if you are calling the server from ltex_extra
                    -- See lspconfig.lua and helper.lua.
                    server_opts = {
                        capabilities = capabilities,
                        on_attach = require('lsp-format').on_attach, -- Enable auto-format on save
                        settings = helper.mason_lsp_configs['ltex'],
                        filetypes = (helper.mason_lsp_configs['ltex'] or {}).filetypes,
                        autostart = (helper.mason_lsp_configs['ltex'] or {}).autostart,
                    },
                })
            end,
        },
    },
    config = function()
        -- vimtex
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_compiler_method = 'latexmk'
        vim.g.vimtex_quickfix_mode = 0
        vim.g.maplocalleader = ' '
    end
}
