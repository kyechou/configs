--
-- https://github.com/jay-babu/mason-nvim-dap.nvim
-- https://github.com/williamboman/mason.nvim
-- https://github.com/mfussenegger/nvim-dap
-- https://github.com/rcarriga/nvim-dap-ui
--

return {
    'jay-babu/mason-nvim-dap.nvim',
    dependencies = {
        'williamboman/mason.nvim',       -- Package manager for LSP/DAP/linter/formatter
        {
            'rcarriga/nvim-dap-ui',      -- Debugger UI for nvim-dep
            dependencies = {
                'mfussenegger/nvim-dap', -- DAP client for neovim
                'nvim-neotest/nvim-nio', -- Required by nvim-dap-ui
            }
        },
    },
    config = function()
        local dap = require('dap')
        local dapui = require('dapui')
        local helper = require('util.helper')

        -- Make sure mason is loaded before mason-lspconfig
        require('mason').setup()
        require('mason-nvim-dap').setup({
            ensure_installed = vim.tbl_keys(helper.mason_dap_configs),
            automatic_installation = false,
            handlers = {},
        })

        -- DAP UI setup, see |:help nvim-dap-ui|
        dapui.setup()
        dap.listeners.before.attach.dapui_config = dapui.open
        dap.listeners.before.launch.dapui_config = dapui.open
        dap.listeners.before.event_terminated.dapui_config = dapui.close
        dap.listeners.before.event_exited.dapui_config = dapui.close

        function DAP_set_conditional_bp()
            dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
        end
    end,
}
