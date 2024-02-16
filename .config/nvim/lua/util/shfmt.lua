--
-- https://github.com/z0mbix/vim-shfmt
--
-- This is needed because the bash language server (bashls) doesn't support
-- formatting.
-- See https://github.com/LunarVim/LunarVim/issues/3048#issuecomment-1252300161
-- shfmt is installed through mason.
--

return {
    'z0mbix/vim-shfmt',
    ft = { 'sh', 'bash' },
    config = function()
        vim.g.shfmt_extra_args = '--indent 4' -- :! shfmt -h
        -- The option shfmt_fmt_on_save doesn't work!!
        -- Set autocmd in init.lua
    end
}
