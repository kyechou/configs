--
-- https://github.com/kevinhwang91/nvim-ufo
--

return {
    'kevinhwang91/nvim-ufo',
    -- event = 'BufRead',
    dependencies = {
        { 'kevinhwang91/promise-async' },
    },
    config = function()
        -- Fold options
        vim.o.fillchars = "fold: ,foldopen:,foldsep:│,foldclose:"
        vim.o.foldcolumn = 'auto' -- '0' is not bad
        vim.o.foldenable = true
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99

        require('ufo').setup({
            provider_selector = function(bufnr, filetype, buftype)
                return { 'treesitter', 'indent' }
            end
        })
    end,
}
