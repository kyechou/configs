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
        local helper = require('util.helper')
        local telescope = require('telescope')
        local actions = require('telescope.actions')
        local builtin = require('telescope.builtin')

        -- local function open(bufnr)
        --     actions.select_default(bufnr)
        --     actions.center(bufnr)
        -- end

        local function open_drop(bufnr)
            require('telescope.actions.set').edit(bufnr, 'drop')
            actions.center(bufnr)
        end

        local function open_tab(bufnr)
            actions.select_tab(bufnr)
            actions.center(bufnr)
        end

        -- local function open_tab_drop(bufnr)
        --     require('telescope.actions.set').edit(bufnr, 'tab drop')
        --     actions.center(bufnr)
        -- end

        local function open_horizontal(bufnr)
            actions.select_horizontal(bufnr)
            actions.center(bufnr)
        end

        local function open_vertical(bufnr)
            actions.select_vertical(bufnr)
            actions.center(bufnr)
        end

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
                path_display = { 'truncate' },
                hl_result_eol = true,
                color_devicons = true,
                mappings = {
                    -- `:help telescope.mappings`
                    -- `:help telescope.actions`
                    i = {
                        ['<C-/>'] = actions.which_key,               -- show key mappings
                        ['<C-q>'] = actions.close,                   -- close telescope
                        ['<C-x>'] = actions.delete_buffer,           -- delete selected buffer
                        ['<C-j>'] = actions.move_selection_next,     -- move down
                        ['<C-k>'] = actions.move_selection_previous, -- move up
                        ['<C-n>'] = actions.preview_scrolling_down,  -- scroll down preview
                        ['<C-p>'] = actions.preview_scrolling_up,    -- scroll up preview
                        ['<C-d>'] = actions.results_scrolling_down,  -- scroll down
                        ['<C-u>'] = actions.results_scrolling_up,    -- scroll up
                        ['<CR>'] = open_drop,                        -- open in current window
                        ['<C-s>'] = open_horizontal,                 -- horizontal split
                        ['<C-t>'] = open_tab,                        -- open in new tab
                        ['<C-v>'] = open_vertical,                   -- vertical split
                        ['<C-a>'] = actions.toggle_all,              -- toggle all selection
                        ['<C-l>'] = false,
                        ['<M-q>'] = false,
                        ['<C-c>'] = false,
                        ['<Down>'] = false,
                        ['<Up>'] = false,
                        ['<PageDown>'] = false,
                        ['<PageUp>'] = false,
                    },
                    n = {
                        ['?'] = actions.which_key,                  -- show key mappings
                        ['<Esc>'] = actions.close,                  -- close telescope
                        ['<C-q>'] = actions.close,                  -- close telescope
                        ['q'] = actions.close,                      -- close telescope
                        ['<C-x>'] = actions.delete_buffer,          -- delete selected buffer
                        ['j'] = actions.move_selection_next,        -- move down
                        ['k'] = actions.move_selection_previous,    -- move up
                        ['G'] = actions.move_to_bottom,             -- move to bottom
                        ['L'] = actions.move_to_bottom,             -- move to bottom
                        ['M'] = actions.move_to_middle,             -- move to middle
                        ['H'] = actions.move_to_top,                -- move to top
                        ['gg'] = actions.move_to_top,               -- move to top
                        ['<C-n>'] = actions.preview_scrolling_down, -- scroll down preview
                        ['<C-p>'] = actions.preview_scrolling_up,   -- scroll up preview
                        ['<C-d>'] = actions.results_scrolling_down, -- scroll down
                        ['<C-u>'] = actions.results_scrolling_up,   -- scroll up
                        ['<CR>'] = open_drop,                       -- open in current window
                        ['<C-s>'] = open_horizontal,                -- horizontal split
                        ['<C-t>'] = open_tab,                       -- open in new tab
                        ['<C-v>'] = open_vertical,                  -- vertical split
                        ['<M-q>'] = false,
                        ['<Down>'] = false,
                        ['<Up>'] = false,
                        ['<PageDown>'] = false,
                        ['<PageUp>'] = false,
                    },
                },
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

        -- Enable telescope extensions, if installed
        pcall(telescope.load_extension, 'fzf')
        pcall(telescope.load_extension, 'session-lens')

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
                        added = '+',
                        changed = '~',
                        copied = '>',
                        deleted = '-',
                        renamed = '➡',
                        unmerged = '‡',
                        untracked = '?',
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
