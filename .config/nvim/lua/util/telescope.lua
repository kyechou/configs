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
        'nvim-telescope/telescope-file-browser.nvim',   -- File browser
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
        local fb_actions = require('telescope._extensions.file_browser.actions')
        local fb_finders = require('telescope._extensions.file_browser.finders')

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
                        ['<CR>'] = actions.select_default,           -- open in current window
                        ['<C-s>'] = actions.select_horizontal,       -- horizontal split
                        ['<C-t>'] = actions.select_tab,              -- open in new tab
                        ['<C-v>'] = actions.select_vertical,         -- vertical split
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
                        ['<CR>'] = actions.select_default,          -- open in current window
                        ['<C-s>'] = actions.select_horizontal,      -- horizontal split
                        ['<C-t>'] = actions.select_tab,             -- open in new tab
                        ['<C-v>'] = actions.select_vertical,        -- vertical split
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
                file_browser = {
                    -- :h telescope-file-browser.picker.file_browser()
                    path = helper.find_git_dir_or_cwd(),
                    cwd = helper.find_git_dir_or_cwd(),
                    cwd_to_path = false,
                    grouped = false,
                    files = true,
                    add_dirs = true,
                    depth = 1,
                    auto_depth = false,
                    select_buffer = false,
                    hidden = { file_browser = true, folder_browser = true },
                    respect_gitignore = vim.fn.executable('fd') == 1,
                    no_ignore = false,
                    follow_symlinks = vim.fn.executable('fd') == 1,
                    browse_files = fb_finders.browse_files,
                    browse_folders = fb_finders.browse_folders,
                    hide_parent_dir = false,
                    collapse_dirs = true,
                    prompt_path = false,
                    quiet = false,
                    use_ui_input = true,
                    dir_icon = '',
                    dir_icon_hl = 'Default',
                    display_stat = { date = true, size = true, mode = true },
                    hijack_netrw = true,
                    use_fd = vim.fn.executable('fd') == 1,
                    git_status = vim.fn.executable('git') == 1,
                    mappings = {
                        ['i'] = {
                            ['<C-a>'] = fb_actions.create,
                            ['<S-CR>'] = fb_actions.create_from_prompt,
                            ['<C-o>'] = fb_actions.open,
                            ['<C-p>'] = fb_actions.goto_parent_dir,
                            ['<C-h>'] = fb_actions.goto_home_dir,
                            ['<C-w>'] = fb_actions.goto_cwd,
                            ['<C-c>'] = fb_actions.change_cwd,
                            ['<C-f>'] = fb_actions.toggle_browser,
                            ['<C-.>'] = fb_actions.toggle_hidden,
                            ['<BS>'] = fb_actions.backspace,
                            ['<CR>'] = actions.select_default,     -- open in current window
                            ['<C-s>'] = actions.select_horizontal, -- horizontal split
                            ['<C-t>'] = actions.select_tab,        -- open in new tab
                            ['<C-v>'] = actions.select_vertical,   -- vertical split
                            ['<A-r>'] = false,
                            ['<A-m>'] = false,
                            ['<A-y>'] = false,
                            ['<A-c>'] = false,
                            ['<A-d>'] = false,
                        },
                        ['n'] = {
                            ['a'] = fb_actions.create,
                            ['r'] = fb_actions.rename,
                            ['x'] = fb_actions.move,
                            ['y'] = fb_actions.copy,
                            ['d'] = fb_actions.remove,
                            ['o'] = fb_actions.open,
                            ['p'] = fb_actions.goto_parent_dir,
                            ['h'] = fb_actions.goto_home_dir,
                            ['w'] = fb_actions.goto_cwd,
                            ['c'] = fb_actions.change_cwd,
                            ['f'] = fb_actions.toggle_browser,
                            ['.'] = fb_actions.toggle_hidden,
                            ['<BS>'] = fb_actions.backspace,
                            ['<CR>'] = actions.select_default,     -- open in current window
                            ['<C-s>'] = actions.select_horizontal, -- horizontal split
                            ['s'] = actions.select_horizontal,     -- horizontal split
                            ['<C-t>'] = actions.select_tab,        -- open in new tab
                            ['t'] = actions.select_tab,            -- open in new tab
                            ['<C-v>'] = actions.select_vertical,   -- vertical split
                            ['v'] = actions.select_vertical,       -- vertical split
                            ['e'] = false,
                            ['g'] = false,
                            ['m'] = false,
                        },
                    },
                },
            },
        })

        -- Enable telescope extensions, if installed
        pcall(telescope.load_extension, 'fzf')
        pcall(telescope.load_extension, 'file_browser')
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
