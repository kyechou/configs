--
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/williamboman/mason.nvim
-- https://github.com/lukas-reineke/lsp-format.nvim
-- https://github.com/hrsh7th/nvim-cmp
--

return {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
        'neovim/nvim-lspconfig',         -- LSP configuration
        'hrsh7th/cmp-nvim-lsp',          -- LSP completion capabilities
        'folke/neodev.nvim',             -- Full signature and completion for nvim Lua
        'lukas-reineke/lsp-format.nvim', -- Use the native LSP formatting
        'williamboman/mason.nvim',       -- Package manager for LSP/DAP/linter/formatter
    },
    config = function()
        -- Make sure mason is loaded before mason-lspconfig
        require('mason').setup()

        -- Ensure the listed language servers are installed
        local helper = require('util.helper')
        require('mason-lspconfig').setup({
            ensure_installed = vim.tbl_keys(helper.mason_lsp_configs),
        })

        -- Apply cmp-nvim-lsp for additional completion capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
        require("neodev").setup()

        require('mason-lspconfig').setup_handlers({
            function(server_name)
                require('lspconfig')[server_name].setup({
                    capabilities = capabilities,
                    on_attach = require('lsp-format').on_attach, -- Enable auto-format on save
                    settings = helper.mason_lsp_configs[server_name],
                    filetypes = (helper.mason_lsp_configs[server_name] or {}).filetypes,
                    autostart = (helper.mason_lsp_configs[server_name] or {}).autostart,
                })
            end,
        })
    end,
}
