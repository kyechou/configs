--
-- https://github.com/akinsho/toggleterm.nvim
--

return {
    'akinsho/toggleterm.nvim',
    config = function()
        require('toggleterm').setup({
            -- size can be a number or function which is passed the current terminal
            size = function(term)
                if term.direction == 'horizontal' then
                    return 20
                elseif term.direction == 'vertical' then
                    return 80
                end
            end,
            open_mapping = '<C-j>',
            -- on_create = function(term) end, -- function to run on create
            -- on_open = function(term) end,   -- function to run on open
            -- on_close = function(term) end,  -- function to run on close
            -- on_exit = function(term) end,   -- function to run on exit
            hide_numbers = true,      -- hide the number column in term buffers
            autochdir = false,        -- term cd with neovim
            shade_terminals = false,  -- make term bg darker
            shading_factor = '-30',   -- percentage by which the term bg is lightened
            start_in_insert = true,
            insert_mappings = true,   -- whether `open_mapping` applies in insert mode
            terminal_mappings = true, -- whether `open_mapping` applies in the opened terminals
            persist_size = false,     -- whether the previous term size is remembered
            persist_mode = true,      -- whether the previous term mode is remembered
            direction = 'float',      -- 'vertical', 'horizontal', 'tab', 'float'
            close_on_exit = true,     -- close term window on exit
            shell = vim.o.shell,      -- default shell (string | func)
            auto_scroll = false,      -- scroll to the bottom on term output
            float_opts = {
                border = 'rounded',   -- See :h nvim_open_win for details on borders.
                winblend = 0,         -- 0: no transparency
                title_pos = 'center', -- 'left', 'center', 'right'
            },
            winbar = {
                enabled = false,
                name_formatter = function(term)
                    return term.name
                end,
            },
        })

        local helper = require('util.helper')

        function TERM_toggle()
            require('toggleterm').toggle(
                nil,                          -- count
                nil,                          -- size
                helper.find_git_dir_or_cwd(), -- dir
                nil,                          -- direction
                nil                           -- name
            )
        end
    end,
}
