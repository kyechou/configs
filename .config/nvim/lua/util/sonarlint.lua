--
-- https://gitlab.com/schrieveslaach/sonarlint.nvim
--

return {
    'https://gitlab.com/schrieveslaach/sonarlint.nvim',
    dependencies = {
        -- 'mfussenegger/nvim-jdtls',       -- Required for Java
        'neovim/nvim-lspconfig',         -- LSP configuration
        'hrsh7th/cmp-nvim-lsp',          -- LSP completion capabilities
        'folke/neodev.nvim',             -- Full signature and completion for nvim Lua
        'lukas-reineke/lsp-format.nvim', -- Use the native LSP formatting
    },
    config = function()
        -- Apply cmp-nvim-lsp for additional completion capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
        require("neodev").setup()

        require('sonarlint').setup({
            capabilities = capabilities,
            on_attach = require('lsp-format').on_attach, -- Enable auto-format on save
            filetypes = { 'python', 'cpp', --[[ 'java', ]] 'text' },
            server = {
                'sonarlint-language-server',
                '-stdio',
                '-analyzers',
                vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
                -- vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
                vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
                vim.fn.expand("$MASON/share/sonarlint-analyzers/sonartext.jar"),
            },
        })
    end,
}
