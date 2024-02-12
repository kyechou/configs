--
-- https://github.com/neovim/nvim-lspconfig
-- https://github.com/williamboman/mason-lspconfig.nvim
-- https://github.com/williamboman/mason.nvim
-- https://github.com/lukas-reineke/lsp-format.nvim
-- https://github.com/j-hui/fidget.nvim
-- https://github.com/hrsh7th/nvim-cmp
--

-- Language servers
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local servers = {
    clangd = {},   -- https://clangd.llvm.org/installation.html
    cmake = {},    -- https://github.com/regen100/cmake-language-server
    cssls = {},    -- https://github.com/hrsh7th/vscode-langservers-extracted
    dockerls = {}, -- https://github.com/rcjsuen/dockerfile-language-server
    html = {},     -- https://github.com/hrsh7th/vscode-langservers-extracted
    jsonls = {},   -- https://github.com/hrsh7th/vscode-langservers-extracted
    ltex = {},     -- https://github.com/valentjn/ltex-ls
    lua_ls = {},   -- https://luals.github.io/wiki/settings/
    marksman = {}, -- https://github.com/artempyanykh/marksman
    pyright = {},  -- https://github.com/microsoft/pyright
    taplo = {},    -- https://taplo.tamasfe.dev/cli/usage/language-server.html (TOML)
}

return {
    'neovim/nvim-lspconfig',
    dependencies = {
        {
            'williamboman/mason-lspconfig.nvim', -- Configure LSPs
            dependencies = { {
                'williamboman/mason.nvim',       -- Automatically install LSPs
                config = true
            } },
            config = true,
        },
        {
            'lukas-reineke/lsp-format.nvim', -- Use the native LSP formatting
            config = true,
        },
        {
            'j-hui/fidget.nvim', -- LSP progress messages
            config = true,
        },
        'hrsh7th/cmp-nvim-lsp', -- LSP completion capabilities
        'folke/neodev.nvim',    -- Full signature and completion for nvim Lua
    },
    config = function()
        -- Ensure the servers above are installed
        require('mason-lspconfig').setup({
            ensure_installed = vim.tbl_keys(servers),
        })

        -- Enable auto-format when the client attaches to the server.
        local on_attach = function(client, bufnr)
            -- Enable auto-format on save
            require('lsp-format').on_attach(client, bufnr)
        end

        -- Apply nvim-cmp for additional completion capabilities
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        -- IMPORTANT: make sure to setup neodev BEFORE lspconfig
        require("neodev").setup()

        require('mason-lspconfig').setup_handlers({
            function(server_name)
                require('lspconfig')[server_name].setup({
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = servers[server_name],
                    filetypes = (servers[server_name] or {}).filetypes,
                })
            end,
        })

        -- List workspace folders
        function LSP_list_workspace_folders()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end
    end,
}
