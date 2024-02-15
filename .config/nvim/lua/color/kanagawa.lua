--
-- https://github.com/rebelot/kanagawa.nvim
--

return {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('kanagawa').setup({
            overrides = function(colors)
                return {
                    Todo = {
                        fg = colors.theme.diag.info,
                        bg = 'none',
                        italic = true,
                        bold = true,
                    },
                    Boolean = {
                        bold = false,
                    },
                }
            end,
        })
    end,
}
