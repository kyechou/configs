--
-- https://github.com/nvim-tree/nvim-tree.lua
--

return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        -- Trash all marked. If nothing is marked, trash the current node under
        -- cursor.
        local function trash()
            local api = require('nvim-tree.api')
            if next(api.marks.list()) == nil then
                api.fs.trash()
            else
                api.marks.bulk.trash()
            end
        end

        -- Delete all marked. If nothing is marked, delete the current node
        -- under cursor.
        local function delete()
            local api = require('nvim-tree.api')
            if next(api.marks.list()) == nil then
                api.fs.remove()
            else
                api.marks.bulk.delete()
            end
        end

        -- Prompt for a directory to move all marked into. If nothing is marked,
        -- print an inform message and do nothing.
        local function move()
            local api = require('nvim-tree.api')
            if next(api.marks.list()) == nil then
                print('Nothing is marked to move')
            else
                api.marks.bulk.move()
            end
        end

        -- Expand recursively if the current node is a folder.
        local function expand_recursive()
            local api = require('nvim-tree.api')
            local node = api.tree.get_node_under_cursor()
            if node.type == 'directory' then
                api.tree.expand_all()
            end
        end

        -- Collapse recursively.
        local function collapse_recursive()
            require('nvim-tree.api').tree.collapse_all()
        end

        -- Expand one level if the current node is a closed folder.
        local function expand_one_level()
            local api = require('nvim-tree.api')
            local node = api.tree.get_node_under_cursor()
            if node.type == 'directory' and not node.open then
                api.node.open.edit()
            end
        end

        -- Collapse one level. If the current node is a file, collapse their
        -- parent folder.
        local function collapse_one_level()
            local api = require('nvim-tree.api')
            local node = api.tree.get_node_under_cursor()
            if node.type == 'directory' and node.open then
                api.node.open.edit()
            elseif node.type == 'file' then
                api.node.navigate.parent_close()
            end
        end

        local function nvtree_on_attach(bufnr)
            local api = require('nvim-tree.api')
            local function opts(desc)
                local nvtree_desc = nil
                if desc and string.len(desc) > 0 then
                    nvtree_desc = 'nvim-tree: ' .. desc
                end
                return {
                    desc = nvtree_desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true
                }
            end

            -- Custom mappings
            vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
            vim.keymap.set('n', '<C-c>', api.marks.clear, opts('Clear all marks'))
            vim.keymap.set('n', '<C-h>', api.tree.change_root_to_parent, opts('Up'))
            vim.keymap.set('n', '<C-l>', api.tree.change_root_to_node, opts('CD'))
            vim.keymap.set('n', '<C-r>', api.tree.reload, opts('Refresh'))
            vim.keymap.set('n', '<C-s>', api.node.open.horizontal, opts('Open split'))
            vim.keymap.set('n', '<C-t>', api.node.open.tab_drop, opts('Open in new tab'))
            vim.keymap.set('n', '<C-v>', api.node.open.vertical, opts('Open vertical split'))
            vim.keymap.set('n', '<CR>', api.node.open.drop, opts('Open'))
            vim.keymap.set('n', '<Space>', api.marks.toggle, opts('Toggle mark'))
            vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('Toggle hidden files'))
            vim.keymap.set('n', 'a', api.fs.create, opts('Create'))
            vim.keymap.set('n', 'c', collapse_recursive, opts('Collapse all'))
            vim.keymap.set('n', 'd', trash, opts('Trash'))
            vim.keymap.set('n', 'D', delete, opts('Delete'))
            vim.keymap.set('n', 'e', expand_recursive, opts('Expand all'))
            vim.keymap.set('n', 'f', api.live_filter.start, opts('Filter'))
            vim.keymap.set('n', 'F', api.live_filter.clear, opts('Clear filter'))
            vim.keymap.set('n', 'h', collapse_one_level, opts('Collapse'))
            vim.keymap.set('n', 'K', api.node.show_info_popup, opts('Info'))
            vim.keymap.set('n', 'l', expand_one_level, opts('Expand'))
            vim.keymap.set('n', 'm', move, opts('Move marked'))
            vim.keymap.set('n', 'p', api.fs.paste, opts('Paste'))
            vim.keymap.set('n', 'q', api.tree.close, opts('Close'))
            vim.keymap.set('n', 'r', api.fs.rename, opts('Rename'))
            vim.keymap.set('n', 's', api.tree.search_node, opts('Search'))
            vim.keymap.set('n', 'x', api.fs.cut, opts('Cut'))
            vim.keymap.set('n', 'yy', api.fs.copy.node, opts('Copy'))
            vim.keymap.set('n', 'yc', api.fs.copy.node, opts('Clear copies'))
            vim.keymap.set('n', 'yn', api.fs.copy.filename, opts('Copy Name'))
            vim.keymap.set('n', 'yp', api.fs.copy.relative_path, opts('Copy Relative Path'))
            vim.keymap.set('n', 'yP', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
            vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts('Open'))
        end

        -- Disable netrw
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1

        require('nvim-tree').setup({
            -- :h nvim-tree-setup
            -- :h nvim-tree-opts
            -- Options with default values are commented. Uninteresting defaults
            -- are removed.
            on_attach = nvtree_on_attach,
            hijack_cursor = true,
            disable_netrw = true,
            hijack_unnamed_buffer_when_opening = true,
            sync_root_with_cwd = true,
            -- reload_on_bufenter = false,
            -- respect_buf_cwd = false,
            select_prompts = true,
            view = {
                centralize_selection = true,
                -- side = 'left',
                preserve_window_proportions = true,
                signcolumn = 'auto',
                width = {
                    min = 36,
                    max = '40%',
                    padding = 1,
                },
            },
            renderer = {
                -- group_empty = false,
                -- full_name = false,
                indent_width = 3,
                special_files = {},
                highlight_git = 'icon', -- none, icon, name, all
                highlight_diagnostics = 'icon',
                -- highlight_opened_files = 'none',
                -- highlight_modified = 'none',
                -- highlight_bookmarks = 'none',
                -- highlight_clipboard = 'name',
                indent_markers = {
                    enable = true,
                    -- inline_arrows = true,
                    -- icons = {
                    --     corner = '└',
                    --     edge = '│',
                    --     item = '│',
                    --     bottom = '─',
                    --     none = ' ',
                    -- },
                },
                icons = {
                    git_placement = 'signcolumn',
                    -- diagnostics_placement = 'signcolumn',
                    -- modified_placement = 'after',
                    -- bookmarks_placement = 'signcolumn',
                    padding = '  ',
                    glyphs = {
                        git = {
                            unstaged = '✗',
                            staged = '✓',
                            unmerged = '',
                            renamed = 'R',
                            untracked = 'U',
                            deleted = 'D',
                            ignored = '◌',
                        },
                    },
                },
            },
            update_focused_file = {
                enable = true,
                -- update_root = false,
                -- ignore_list = {},
            },
            -- git = {
            --     enable = true,
            --     show_on_dirs = true,
            --     show_on_open_dirs = true,
            -- },
            diagnostics = {
                enable = true,
                -- show_on_dirs = false,
                -- show_on_open_dirs = true,
            },
            modified = {
                enable = true,
                -- show_on_dirs = true,
                -- show_on_open_dirs = true,
            },
            -- filters = {
            --     git_ignored = true,
            --     dotfiles = false,
            -- },
            live_filter = {
                prefix = '[filter]: ',
                -- always_show_folders = true,
            },
            actions = {
                -- change_dir = {
                --     enable = true,
                --     global = false,
                --     restrict_above_cwd = false,
                -- },
                expand_all = {
                    -- max_folder_discovery = 300,
                    exclude = { '.git' },
                },
                -- open_file = {
                --     quit_on_open = false,
                -- },
                -- remove_file = {
                --     close_window = true,
                -- },
            },
            tab = {
                sync = {
                    open = true,
                    close = true,
                    -- ignore = {},
                },
            },
            help = {
                sort_by = 'desc',
            },
            ui = {
                confirm = {
                    -- remove = true,
                    -- trash = true,
                    default_yes = true,
                },
            },
        })

        -- Toggle nvim-tree without switching cursor.
        function NVT_toggle()
            local api = require('nvim-tree.api')
            api.tree.toggle({ focus = false })
        end
    end
}
