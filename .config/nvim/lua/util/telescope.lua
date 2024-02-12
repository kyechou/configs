--
-- https://github.com/nvim-telescope/telescope.nvim
-- `:help telescope`
-- `:help telescope.setup()`
-- `:help telescope.builtin`
--

return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons',
        {
            'nvim-telescope/telescope-fzf-native.nvim', -- FZF sorter in C
            build =
                'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && ' ..
                'cmake --build build --config Release && ' ..
                'cmake --install build --prefix build',
            cond = function()
                return vim.fn.executable('cmake') == 1
            end,
        },
    },
    config = function()
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')

        telescope.setup({
            defaults = {
                sorting_strategy = 'descending',
                selection_strategy = 'reset',
                scroll_strategy = 'limit',
                -- Swap between horizontal and vertical based on the window width
                layout_strategy = 'flex',
                winblend = 0, -- fully opaque bg for floating window
                wrap_results = false,
                prompt_prefix = '',
                selection_caret = '⏵ ',
                entry_prefix = '  ',
                multi_icon = '+',
                initial_mode = 'insert',
                border = true,
                path_display = { 'smart' },
                hl_result_eol = true,
                color_devicons = true,
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    -- 'ignore_case', 'respect_case', 'smart_case'
                    case_mode = 'smart_case',
                },
            },
        })

        -- Enable telescope fzf native, if installed
        pcall(telescope.load_extension, 'fzf')

        -- Return the git base directory based on the current buffer's path if it is a
        -- git repository. Otherwise, return nil.
        function TLSCP_find_git_dir()
            -- Use the current buffer's path as the starting point for the git search
            local current_file = vim.api.nvim_buf_get_name(0)
            local current_dir
            local cwd = vim.fn.getcwd()
            if current_file == '' then
                -- If the buffer is not associated with a file, use cwd
                current_dir = cwd
            else
                -- Extract the directory from the current file's path
                current_dir = vim.fn.fnamemodify(current_file, ':h')
            end

            -- Find the git base directory from the current file's path
            local git_dir = vim.fn.systemlist(
                'git -C ' .. vim.fn.escape(current_dir, ' ') ..
                ' rev-parse --show-toplevel')[1]
            if vim.v.shell_error ~= 0 then
                return nil
            end
            return git_dir
        end

        -- Return the git base directory based on the current buffer's path if it is a
        -- git repository. Otherwise, return the current working directory.
        function TLSCP_find_git_dir_or_cwd()
            local dir = TLSCP_find_git_dir()
            if dir then
                return dir
            end
            return vim.fn.getcwd()
        end

        -- Search for a string in a git repository or cwd
        function TLSCP_live_grep_in_git_or_cwd()
            builtin.live_grep({ search_dirs = { TLSCP_find_git_dir_or_cwd() } })
        end

        -- Search for a string from open files
        function TLSCP_live_grep_open_files()
            builtin.live_grep({
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            })
        end

        -- Search for a file in a git repository or cwd
        function TLSCP_find_git_files_or_from_cwd()
            local git_dir = TLSCP_find_git_dir()
            if git_dir then
                builtin.git_files({
                    cwd = git_dir,
                    use_git_root = true,
                    show_untracked = true
                })
            else
                builtin.find_files({ follow = true, hidden = true })
            end
        end

        -- Search from all diagnostics of the git repo or cwd
        function TLSCP_diagnostics()
            builtin.diagnostics({
                bufnr = nil, -- 0: current buffer, nil: all buffers
                severity_limit = vim.diagnostic.severity.HINT,
                root_dir = TLSCP_find_git_dir_or_cwd(),
                no_unlisted = true,
            })
        end

        -- Search from man pages
        function TLSCP_man_pages()
            builtin.man_pages({ sections = { 'ALL' } })
        end

        function TLSCP_git_status()
            local git_dir = TLSCP_find_git_dir()
            if git_dir then
                builtin.git_status({
                    cwd = git_dir,
                    use_git_root = true,
                })
            else
                print(vim.fn.getcwd() .. ' is not a git directory')
            end
        end

        function TLSCP_git_stash()
            local git_dir = TLSCP_find_git_dir()
            if git_dir then
                builtin.git_stash({
                    cwd = git_dir,
                    use_git_root = true,
                })
            else
                print(vim.fn.getcwd() .. ' is not a git directory')
            end
        end

        function TLSCP_git_branches()
            local git_dir = TLSCP_find_git_dir()
            if git_dir then
                builtin.git_branches({
                    cwd = git_dir,
                    use_git_root = true,
                })
            else
                print(vim.fn.getcwd() .. ' is not a git directory')
            end
        end

        function TLSCP_git_commits()
            local git_dir = TLSCP_find_git_dir()
            if git_dir then
                builtin.git_commits({
                    cwd = git_dir,
                    use_git_root = true,
                })
            else
                print(vim.fn.getcwd() .. ' is not a git directory')
            end
        end
    end
}
