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
        local helper = require('util.helper')

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

        -- Search for a string in a git repository or cwd
        function TLSCP_live_grep_in_git_or_cwd()
            builtin.live_grep({ search_dirs = { helper.find_git_dir_or_cwd() } })
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
            local git_dir = helper.find_git_dir()
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
                root_dir = helper.find_git_dir_or_cwd(),
                no_unlisted = true,
            })
        end

        -- Search from man pages
        function TLSCP_man_pages()
            builtin.man_pages({ sections = { 'ALL' } })
        end

        function TLSCP_git_status()
            local git_dir = helper.find_git_dir()
            if git_dir then
                builtin.git_status({
                    cwd = git_dir,
                    use_git_root = true,
                    git_icons = { -- See make_entry.lua git_icon_defaults
                        added = "+",
                        changed = "~",
                        copied = ">",
                        deleted = "-",
                        renamed = "➡",
                        unmerged = "‡",
                        untracked = "?",
                    },
                })
            else
                print(vim.fn.getcwd() .. ' is not a git directory')
            end
        end

        function TLSCP_git_stash()
            local git_dir = helper.find_git_dir()
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
            local git_dir = helper.find_git_dir()
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
            local git_dir = helper.find_git_dir()
            if git_dir then
                builtin.git_commits({
                    cwd = git_dir,
                    use_git_root = true,
                })
            else
                print(vim.fn.getcwd() .. ' is not a git directory')
            end
        end

        function TLSCP_list_buffers()
            builtin.buffers({
                show_all_buffers = true,
                ignore_current_buffer = false,
                sort_mru = true, -- Sort by most-recent used
            })
        end
    end
}
