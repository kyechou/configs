--
-- https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim
--

return {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    dependencies = {
        {
            -- Package manager for LSP/DAP/linter/formatter
            'williamboman/mason.nvim',
            config = true
        },
        {
            -- Allow lspconfig package names besides Mason package names
            'williamboman/mason-lspconfig.nvim',
            config = true
        },
    },
    config = function()
        local helper = require('util.helper')
        require('mason-tool-installer').setup({
            ensure_installed = helper.mason_packages,
            auto_update = false,
            run_on_start = true,
            start_delay = 0,    -- (ms) only effective if run_on_start is true
            debounce_hours = 5, -- (hr) only effective if run_on_start is true
        })
    end,
}
