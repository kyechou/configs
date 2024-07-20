--
-- https://github.com/folke/which-key.nvim
--

return {
    'folke/which-key.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        { 'echasnovski/mini.icons', config = true },
    },
    event = 'VeryLazy',
}
