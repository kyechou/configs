--
-- https://github.com/lervag/vimtex
-- https://github.com/vigoux/ltex-ls.nvim
--

return {
    'lervag/vimtex',
    dependencies = {
        {
            'vigoux/ltex-ls.nvim',               -- Enhanced integration of ltex-ls (needed for dictionaries)
            dependencies = {
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

                require('ltex-ls').setup({
                    use_spellfile = false,
                    window_border = 'single',
                    capabilities = capabilities,
                    on_attach = require('lsp-format').on_attach, -- Enable auto-format on save
                    settings = {
                        ltex = {
                            enabled = { 'latex', 'tex', 'bib', 'markdown' },
                            language = 'auto',
                            diagnosticSeverity = 'information',
                            dictionary = (function()
                                -- For dictionary, search for files in the runtime to have
                                -- and include them as externals the format for them is
                                -- dict/{LANG}.txt
                                -- Also add dict/default.txt to all of them
                                local files = {}
                                for _, file in ipairs(vim.api.nvim_get_runtime_file('dict/*', true)) do
                                    local lang = vim.fn.fnamemodify(file, ':t:r')
                                    local fullpath = vim.fs.normalize(file)
                                    files[lang] = { ':' .. fullpath }
                                end

                                if files.default then
                                    for lang, _ in pairs(files) do
                                        if lang ~= 'default' then
                                            vim.list_extend(files[lang], files.default)
                                        end
                                    end
                                    files.default = nil
                                end
                                return files
                            end)(),
                        },
                    },
                })
            end,
        },
    },
    config = function()
        vim.g.vimtex_view_method = 'zathura'
        vim.g.vimtex_compiler_method = 'latexmk'
        vim.g.maplocalleader = ' '
    end
}
