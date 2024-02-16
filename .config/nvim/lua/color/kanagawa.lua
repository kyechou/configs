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
                    ['@diff.add'] = { fg = colors.theme.vcs.added },
                    ['@diff.delete'] = { fg = colors.theme.vcs.removed },
                    ['@text.diff.add'] = { fg = colors.theme.vcs.added },
                    ['@text.diff.delete'] = { fg = colors.theme.vcs.removed },
                }
            end,
        })
    end,
}
