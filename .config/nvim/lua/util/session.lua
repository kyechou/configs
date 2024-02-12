--
-- https://github.com/rmagatti/auto-session
--

return {
    'rmagatti/auto-session',
    config = function()
        local session_dir = vim.fn.stdpath('data') .. '/sessions/'

        require('auto-session').setup({
            log_level = 'error',
            auto_session_enable_last_session = false,
            auto_session_root_dir = session_dir,
            auto_session_last_session_dir = session_dir,
            auto_session_enabled = true,
            -- Do not auto-create new sessions.
            -- Sessions need to be manually created for the first time.
            auto_session_create_enabled = false,
            auto_save_enabled = nil,
            auto_restore_enabled = nil,
            auto_session_suppress_dirs = nil,
            auto_session_allowed_dirs = nil,
            auto_session_use_git_branch = nil,

            session_lens = {
                -- If load_on_setup is set to false, one needs to
                -- eventually call `require("auto-session").setup_session_lens()`
                -- if they want to use session-lens.
                load_on_setup = true,
                -- list of buffer types that should not be deleted from current session
                buftypes_to_ignore = {},
                path_display = { 'absolute' },
                theme_conf = { border = true },
                previewer = true,
            },
        })
    end
}
