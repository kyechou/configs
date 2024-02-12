--
-- https://github.com/lewis6991/gitsigns.nvim
-- `:help gitsigns.txt`
--

return {
    'lewis6991/gitsigns.nvim',
    config = function()
        require('gitsigns').setup({
            signcolumn = true,
            numhl = true,
            linehl = false,
            word_diff = false,
            current_line_blame = false,
            -- on_attach = function(bufnr) end,
        })

        local gitsigns = package.loaded.gitsigns

        function GS_next_hunk(key)
            if vim.wo.diff then
                return key
            end
            vim.schedule(function() gitsigns.next_hunk() end)
            return '<Ignore>'
        end

        function GS_prev_hunk(key)
            if vim.wo.diff then
                return key
            end
            vim.schedule(function() gitsigns.prev_hunk() end)
            return '<Ignore>'
        end

        function GS_v_stage_hunk()
            gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end

        function GS_v_reset_hunk()
            gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
        end

        function GS_blame_line()
            gitsigns.blame_line({ full = true, ignore_whitespace = true })
        end
    end,
}
