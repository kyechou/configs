--
-- https://github.com/Exafunction/codeium.nvim
--

return {
    'Exafunction/codeium.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'hrsh7th/nvim-cmp',
    },
    config = function()
        require('codeium').setup({
            enable_chat = false,
            enable_local_search = true,
            enable_index_service = true,
        })
    end,
}
