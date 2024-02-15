--
-- https://github.com/gu-fan/lastbuf.vim

--

return {
    'gu-fan/lastbuf.vim',
    config = function()
        vim.g.lastbuf_num = 10 -- max number of reopen buffers (stack size)

        -- This option decides to reopen which level of hided buffer.
        -- :hid   bufhidden  (will always be reopened)
        -- :bun   bufunload  (will be reopened if level >= 1)
        -- :bd    bufdelete  (will be reopened if level >= 2)
        -- :bw    bufwipeout (will never be reopened!CAUTION!!)
        -- default is 1 , means :bd and :bw not be reopened.
        -- if you want the same effect of 'nohidden'.
        -- set it to 0 and  set 'nohidden'
        vim.g.lastbuf_level = 1

        -- Unmap the default mapping
        vim.keymap.del('n', '<C-w><C-z>')
    end
}
