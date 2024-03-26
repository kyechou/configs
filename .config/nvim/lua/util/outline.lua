--
-- https://github.com/stevearc/aerial.nvim
-- https://github.com/hedyhli/outline.nvim
--

return {
    'stevearc/aerial.nvim',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    opts = {
        -- Priority list of preferred backends for aerial.
        -- This can be a filetype map (see :help aerial-filetype-map)
        backends = { 'treesitter', 'lsp', 'markdown', 'man' },

        layout = {
            -- These control the width of the aerial window.
            -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_width and max_width can be a list of mixed types.
            -- max_width = {40, 0.2} means "the lesser of 40 columns or 20% of total"
            max_width = { 50, 0.4 },
            width = nil,
            min_width = 25,

            -- key-value pairs of window-local options for aerial window (e.g. winhl)
            win_opts = {},

            -- Determines the default direction to open the aerial window. The 'prefer'
            -- options will open the window in the other direction *if* there is a
            -- different buffer in the way of the preferred direction
            -- Enum: prefer_right, prefer_left, right, left, float
            default_direction = 'left',

            -- Determines where the aerial window will be opened
            --   edge   - open aerial at the far right/left of the editor
            --   window - open aerial to the right/left of the current window
            placement = 'edge',

            -- When the symbols change, resize the aerial window (within min/max constraints) to fit
            resize_to_content = true,

            -- Preserve window size equality with (:help CTRL-W_=)
            preserve_equality = false,
        },

        -- Determines how the aerial window decides which buffer to display symbols for
        --   window - aerial window will display symbols for the buffer in the window from which it was opened
        --   global - aerial window will display symbols for the current window
        attach_mode = 'global',

        -- List of enum values that configure when to auto-close the aerial window
        --   unfocus       - close aerial when you leave the original source window
        --   switch_buffer - close aerial when you change buffers in the source window
        --   unsupported   - close aerial when attaching to a buffer that has no symbol source
        close_automatic_events = {},

        -- Keymaps in aerial window. Can be any value that `vim.keymap.set` accepts OR a table of keymap
        -- options with a `callback` (e.g. { callback = function() ... end, desc = "", nowait = true })
        -- Additionally, if it is a string that matches "actions.<name>",
        -- it will use the mapping at require("aerial.actions").<name>
        -- Set to `false` to remove a keymap
        keymaps = {
            ['?'] = 'actions.show_help',
            ['g?'] = 'actions.show_help',
            ['<CR>'] = 'actions.jump',
            ['<2-LeftMouse>'] = 'actions.jump',
            ['<C-v>'] = 'actions.jump_vsplit',
            ['<C-s>'] = 'actions.jump_split',
            ['p'] = 'actions.scroll',
            ['<C-j>'] = 'actions.down_and_scroll',
            ['<C-k>'] = 'actions.up_and_scroll',
            ['{'] = 'actions.prev',
            ['}'] = 'actions.next',
            ['[['] = 'actions.prev_up',
            [']]'] = 'actions.next_up',
            ['q'] = 'actions.close',
            ['o'] = 'actions.tree_toggle',
            ['za'] = 'actions.tree_toggle',
            ['O'] = 'actions.tree_toggle_recursive',
            ['zA'] = 'actions.tree_toggle_recursive',
            ['l'] = 'actions.tree_open',
            ['zo'] = 'actions.tree_open',
            ['L'] = 'actions.tree_open_recursive',
            ['zO'] = 'actions.tree_open_recursive',
            ['h'] = 'actions.tree_close',
            ['zc'] = 'actions.tree_close',
            ['H'] = 'actions.tree_close_recursive',
            ['zC'] = 'actions.tree_close_recursive',
            ['zr'] = 'actions.tree_increase_fold_level',
            ['zR'] = 'actions.tree_open_all',
            ['zm'] = 'actions.tree_decrease_fold_level',
            ['zM'] = 'actions.tree_close_all',
            ['zx'] = 'actions.tree_sync_folds',
            ['zX'] = 'actions.tree_sync_folds',
        },

        -- When true, don't load aerial until a command or function is called
        -- Defaults to true, unless `on_attach` is provided, then it defaults to false
        lazy_load = true,

        -- Disable aerial on files with this many lines
        disable_max_lines = 10000,

        -- Disable aerial on files this size or larger (in bytes)
        disable_max_size = 2000000, -- Default 2MB

        -- A list of all symbols to display. Set to false to display all symbols.
        -- This can be a filetype map (see :help aerial-filetype-map)
        -- To see all available values, see :help SymbolKind
        filter_kind = {
            'Class',
            'Constructor',
            'Enum',
            'Function',
            'Interface',
            'Method',
            'Module',
            'Namespace',
            'Package',
            'Struct',
        },

        -- Determines line highlighting mode when multiple splits are visible.
        -- split_width   Each open window will have its cursor location marked in the
        --               aerial buffer. Each line will only be partially highlighted
        --               to indicate which window is at that location.
        -- full_width    Each open window will have its cursor location marked as a
        --               full-width highlight in the aerial buffer.
        -- last          Only the most-recently focused window will have its location
        --               marked in the aerial buffer.
        -- none          Do not show the cursor locations in the aerial window.
        highlight_mode = 'split_width',

        -- Highlight the closest symbol if the cursor is not exactly on one.
        highlight_closest = true,

        -- Highlight the symbol in the source buffer when cursor is in the aerial win
        highlight_on_hover = false,

        -- When jumping to a symbol, highlight the line for this many ms.
        -- Set to false to disable
        highlight_on_jump = false,

        -- Jump to symbol in source window when the cursor moves
        autojump = false,

        -- Define symbol icons. You can also specify "<Symbol>Collapsed" to change the
        -- icon when the tree is collapsed at that symbol, or "Collapsed" to specify a
        -- default collapsed icon. The default icon set is determined by the
        -- "nerd_font" option below.
        -- If you have lspkind-nvim installed, it will be the default icon set.
        -- This can be a filetype map (see :help aerial-filetype-map)
        icons = {},

        -- Control which windows and buffers aerial should ignore.
        -- Aerial will not open when these are focused, and existing aerial windows will not be updated
        ignore = {
            -- Ignore unlisted buffers. See :help buflisted
            unlisted_buffers = false,

            -- List of filetypes to ignore.
            filetypes = {},

            -- Ignored buftypes.
            -- Can be one of the following:
            -- false or nil - No buftypes are ignored.
            -- "special"    - All buffers other than normal, help and man page buffers are ignored.
            -- table        - A list of buftypes to ignore. See :help buftype for the
            --                possible values.
            -- function     - A function that returns true if the buffer should be
            --                ignored or false if it should not be ignored.
            --                Takes two arguments, `bufnr` and `buftype`.
            buftypes = 'special',

            -- Ignored wintypes.
            -- Can be one of the following:
            -- false or nil - No wintypes are ignored.
            -- "special"    - All windows other than normal windows are ignored.
            -- table        - A list of wintypes to ignore. See :help win_gettype() for the
            --                possible values.
            -- function     - A function that returns true if the window should be
            --                ignored or false if it should not be ignored.
            --                Takes two arguments, `winid` and `wintype`.
            wintypes = 'special',
        },

        -- Use symbol tree for folding. Set to true or false to enable/disable
        -- Set to "auto" to manage folds if your previous foldmethod was 'manual'
        -- This can be a filetype map (see :help aerial-filetype-map)
        manage_folds = false,

        -- When you fold code with za, zo, or zc, update the aerial tree as well.
        -- Only works when manage_folds = true
        link_folds_to_tree = false,

        -- Fold code when you open/collapse symbols in the tree.
        -- Only works when manage_folds = true
        link_tree_to_folds = false,

        -- Set default symbol icons to use patched font icons (see https://www.nerdfonts.com/)
        -- "auto" will set it to true if nvim-web-devicons or lspkind-nvim is installed.
        nerd_font = 'auto',

        -- Call this function when aerial attaches to a buffer.
        -- on_attach = function(bufnr) end,

        -- Call this function when aerial first sets symbols on a buffer.
        -- on_first_symbols = function(bufnr) end,

        -- Automatically open aerial when entering supported buffers.
        -- This can be a function (see :help aerial-open-automatic)
        open_automatic = false,

        -- Run this command after jumping to a symbol (false will disable)
        post_jump_cmd = 'normal! zz',

        -- Invoked after each symbol is parsed, can be used to modify the parsed item,
        -- or to filter it by returning false.
        --
        -- bufnr: a neovim buffer number
        -- item: of type aerial.Symbol
        -- ctx: a record containing the following fields:
        --   * backend_name: treesitter, lsp, man...
        --   * lang: info about the language
        --   * symbols?: specific to the lsp backend
        --   * symbol?: specific to the lsp backend
        --   * syntax_tree?: specific to the treesitter backend
        --   * match?: specific to the treesitter backend, TS query match
        -- post_parse_symbol = function(bufnr, item, ctx)
        --     return true
        -- end,

        -- Invoked after all symbols have been parsed and post-processed,
        -- allows to modify the symbol structure before final display
        --
        -- bufnr: a neovim buffer number
        -- items: a collection of aerial.Symbol items, organized in a tree,
        --        with 'parent' and 'children' fields
        -- ctx: a record containing the following fields:
        --   * backend_name: treesitter, lsp, man...
        --   * lang: info about the language
        --   * symbols?: specific to the lsp backend
        --   * syntax_tree?: specific to the treesitter backend
        -- post_add_all_symbols = function(bufnr, items, ctx)
        --     return items
        -- end,

        -- When true, aerial will automatically close after jumping to a symbol
        close_on_select = false,

        -- The autocmds that trigger symbols update (not used for LSP backend)
        update_events = 'TextChanged,InsertLeave',

        -- Show box drawing characters for the tree hierarchy
        show_guides = true,

        -- Customize the characters used when show_guides = true
        guides = {
            -- When the child item has a sibling below it
            mid_item = '├─',
            -- When the child item is the last in the list
            last_item = '└─',
            -- When there are nested child guides to the right
            nested_top = '│ ',
            -- Raw indentation
            whitespace = '  ',
        },

        -- Set this function to override the highlight groups for certain symbols
        -- get_highlight = function(symbol, is_icon, is_collapsed)
        --     return "MyHighlight" .. symbol.kind
        -- end,

        -- Options for opening aerial in a floating win
        float = {
            -- Controls border appearance. Passed to nvim_open_win
            border = 'rounded',

            -- Determines location of floating window
            --   cursor - Opens float on top of the cursor
            --   editor - Opens float centered in the editor
            --   win    - Opens float centered in the window
            relative = 'win',

            -- These control the height of the floating window.
            -- They can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
            -- min_height and max_height can be a list of mixed types.
            -- min_height = {8, 0.1} means "the greater of 8 rows or 10% of total"
            max_height = 0.9,
            height = nil,
            min_height = { 8, 0.1 },

            -- override = function(conf, source_winid)
            --     -- This is the config that will be passed to nvim_open_win.
            --     -- Change values here to customize the layout
            --     return conf
            -- end,
        },

        -- Options for the floating nav windows
        nav = {
            border = "rounded",
            max_height = 0.9,
            min_height = { 10, 0.1 },
            max_width = 0.6,
            min_width = { 0.2, 20 },
            win_opts = {
                cursorline = true,
                winblend = 0,
            },
            -- Jump to symbol in source window when the cursor moves
            autojump = false,
            -- Show a preview of the code in the right column, when there are no child symbols
            preview = true,
            -- Keymaps in the nav window
            keymaps = {
                ["<CR>"] = "actions.jump",
                ["<2-LeftMouse>"] = "actions.jump",
                ["<C-v>"] = "actions.jump_vsplit",
                ["<C-s>"] = "actions.jump_split",
                ["h"] = "actions.left",
                ["l"] = "actions.right",
                ["q"] = "actions.close",
                ["<Esc>"] = "actions.close",
                ["<C-c>"] = "actions.close",
            },
        },

        lsp = {
            -- Fetch document symbols when LSP diagnostics update.
            -- If false, will update on buffer changes.
            diagnostics_trigger_update = true,

            -- Set to false to not update the symbols when there are LSP errors
            update_when_errors = true,

            -- How long to wait (in ms) after a buffer change before updating
            -- Only used when diagnostics_trigger_update = false
            update_delay = 300,

            -- Map of LSP client name to priority. Default value is 10.
            -- Clients with higher (larger) priority will be used before those with lower priority.
            -- Set to -1 to never use the client.
            priority = {
                -- pyright = 10,
            },
        },

        treesitter = {
            -- How long to wait (in ms) after a buffer change before updating
            update_delay = 300,
        },

        markdown = {
            -- How long to wait (in ms) after a buffer change before updating
            update_delay = 300,
        },

        man = {
            -- How long to wait (in ms) after a buffer change before updating
            update_delay = 300,
        },
    },
}

-- return {
--     'hedyhli/outline.nvim',
--     lazy = true,
--     cmd = { 'Outline', 'OutlineOpen' },
--     opts = {
--         outline_window = {
--             -- Where to open the split window: right/left
--             position = 'left',
--             -- The default split commands used are 'topleft vs' and 'botright vs'
--             -- depending on `position`. You can change this by providing your own
--             -- `split_command`.
--             -- `position` will not be considered if `split_command` is non-nil.
--             -- This should be a valid vim command used for opening the split for the
--             -- outline window. Eg, 'rightbelow vsplit'.
--             split_command = nil,
--
--             -- Percentage or integer of columns
--             width = 40,
--             -- Whether width is relative to the total width of nvim
--             -- When relative_width = true, this means take 25% of the total
--             -- screen width for outline window.
--             relative_width = false,
--
--             -- Auto close the outline window if goto_location is triggered and not for
--             -- peek_location
--             auto_close = false,
--             -- Automatically scroll to the location in code when navigating outline window.
--             auto_jump = false,
--             -- boolean or integer for milliseconds duration to apply a temporary highlight
--             -- when jumping. false to disable.
--             jump_highlight_duration = 300,
--             -- Whether to center the cursor line vertically in the screen when
--             -- jumping/focusing. Executes zz.
--             center_on_jump = true,
--
--             -- Vim options for the outline window
--             show_numbers = false,
--             show_relative_numbers = false,
--             wrap = false,
--
--             -- true/false/'focus_in_outline'/'focus_in_code'.
--             -- The last two means only show cursorline when the focus is in outline/code.
--             -- 'focus_in_outline' can be used if the outline_items.auto_set_cursor
--             -- operations are too distracting due to visual contrast caused by cursorline.
--             show_cursorline = true,
--             -- Enable this only if you enabled cursorline so your cursor color can
--             -- blend with the cursorline, in effect, as if your cursor is hidden
--             -- in the outline window.
--             -- This makes your line of cursor have the same color as if the cursor
--             -- wasn't focused on the outline window.
--             -- This feature is experimental.
--             hide_cursor = false,
--
--             -- Whether to auto-focus on the outline window when it is opened.
--             -- Set to false to *always* retain focus on your previous buffer when opening
--             -- outline.
--             -- If you enable this you can still use bangs in :Outline! or :OutlineOpen! to
--             -- retain focus on your code. If this is false, retaining focus will be
--             -- enforced for :Outline/:OutlineOpen and you will not be able to have the
--             -- other behaviour.
--             focus_on_open = true,
--             -- Winhighlight option for outline window.
--             -- See :help 'winhl'
--             -- To change background color to "CustomHl" for example, use "Normal:CustomHl".
--             winhl = '',
--         },
--
--         outline_items = {
--             -- Show extra details with the symbols (lsp dependent) as virtual text
--             show_symbol_details = true,
--             -- Show corresponding line numbers of each symbol on the left column as
--             -- virtual text, for quick navigation when not focused on outline.
--             -- Why? See this comment:
--             -- https://github.com/simrat39/symbols-outline.nvim/issues/212#issuecomment-1793503563
--             show_symbol_lineno = false,
--             -- Whether to highlight the currently hovered symbol and all direct parents
--             highlight_hovered_item = true,
--             -- Whether to automatically set cursor location in outline to match
--             -- location in code when focus is in code. If disabled you can use
--             -- `:OutlineFollow[!]` from any window or `<C-g>` from outline window to
--             -- trigger this manually.
--             auto_set_cursor = true,
--             -- Autocmd events to automatically trigger these operations.
--             auto_update_events = {
--                 -- Includes both setting of cursor and highlighting of hovered item.
--                 -- The above two options are respected.
--                 -- This can be triggered manually through `follow_cursor` lua API,
--                 -- :OutlineFollow command, or <C-g>.
--                 follow = { 'CursorMoved' },
--                 -- Re-request symbols from the provider.
--                 -- This can be triggered manually through `refresh_outline` lua API, or
--                 -- :OutlineRefresh command.
--                 items = { 'InsertLeave', 'WinEnter', 'BufEnter', 'BufWinEnter', 'TabEnter', 'BufWritePost' },
--             },
--         },
--
--         -- Options for outline guides which help show tree hierarchy of symbols
--         guides = {
--             enabled = true,
--             markers = {
--                 -- It is recommended for bottom and middle markers to use the same number
--                 -- of characters to align all child nodes vertically.
--                 bottom = '└',
--                 middle = '├',
--                 vertical = '│',
--             },
--         },
--
--         symbol_folding = {
--             -- Depth past which nodes will be folded by default. Set to false to unfold all on open.
--             autofold_depth = 1,
--             -- When to auto unfold nodes
--             auto_unfold = {
--                 -- Auto unfold currently hovered symbol
--                 hovered = true,
--                 -- Auto fold when the root level only has this many nodes.
--                 -- Set true for 1 node, false for 0.
--                 only = false,
--             },
--             markers = { '', '' },
--         },
--
--         preview_window = {
--             -- Automatically open preview of code location when navigating outline window
--             auto_preview = false,
--             -- Automatically open hover_symbol when opening preview (see keymaps for
--             -- hover_symbol).
--             -- If you disable this you can still open hover_symbol using your keymap
--             -- below.
--             open_hover_on_preview = false,
--             width = 50,     -- Percentage or integer of columns
--             min_width = 50, -- This is the number of columns
--             -- Whether width is relative to the total width of nvim.
--             -- When relative_width = true, this means take 50% of the total
--             -- screen width for preview window, ensure the result width is at least 50
--             -- characters wide.
--             relative_width = true,
--             -- Border option for floating preview window.
--             -- Options include: single/double/rounded/solid/shadow or an array of border
--             -- characters.
--             -- See :help nvim_open_win() and search for "border" option.
--             border = 'single',
--             -- winhl options for the preview window, see ':h winhl'
--             winhl = 'NormalFloat:',
--             -- Pseudo-transparency of the preview window, see ':h winblend'
--             winblend = 0,
--             -- Experimental feature that let's you edit the source content live
--             -- in the preview window. Like VS Code's "peek editor".
--             live = false
--         },
--
--         -- These keymaps can be a string or a table for multiple keys.
--         -- Set to `{}` to disable. (Using 'nil' will fallback to default keys)
--         keymaps = {
--             show_help = '?',
--             close = { '<Esc>', 'q' },
--             -- Jump to symbol under cursor.
--             -- It can auto close the outline window when triggered, see
--             -- 'auto_close' option above.
--             goto_location = '<CR>',
--             -- Jump to symbol under cursor but keep focus on outline window.
--             peek_location = 'o',
--             -- Visit location in code and close outline immediately
--             goto_and_close = '<S-CR>',
--             -- Change cursor position of outline window to match current location in code.
--             -- 'Opposite' of goto/peek_location.
--             restore_location = '<C-g>',
--             -- Open LSP/provider-dependent symbol hover information
--             hover_symbol = '<C-space>',
--             -- Preview location code of the symbol under cursor
--             toggle_preview = 'K',
--             rename_symbol = 'r',
--             code_actions = 'a',
--             -- These fold actions are collapsing tree nodes, not code folding
--             fold = 'h',
--             unfold = 'l',
--             fold_toggle = '<Tab>',
--             -- Toggle folds for all nodes.
--             -- If at least one node is folded, this action will fold all nodes.
--             -- If all nodes are folded, this action will unfold all nodes.
--             fold_toggle_all = 'F',
--             fold_all = 'W',
--             unfold_all = 'E',
--             fold_reset = 'R',
--             -- Move down/up by one line and peek_location immediately.
--             -- You can also use outline_window.auto_jump=true to do this for any
--             -- j/k/<down>/<up>.
--             down_and_jump = '<C-j>',
--             up_and_jump = '<C-k>',
--         },
--
--         providers = {
--             priority = { 'lsp', 'coc', 'markdown', 'norg' },
--             lsp = {
--                 -- Lsp client names to ignore
--                 blacklist_clients = {},
--             },
--         },
--
--         symbols = {
--             -- Filter by kinds (string) for symbols in the outline.
--             -- Possible kinds are the Keys in the icons table below.
--             -- A filter list is a string[] with an optional exclude (boolean) field.
--             -- The symbols.filter option takes either a filter list or ft:filterList
--             -- key-value pairs.
--             -- Put  exclude=true  in the string list to filter by excluding the list of
--             -- kinds instead.
--             -- Include all except String and Constant:
--             --   filter = { 'String', 'Constant', exclude = true }
--             -- Only include Package, Module, and Function:
--             --   filter = { 'Package', 'Module', 'Function' }
--             -- See more examples below.
--             filter = nil,
--
--             -- You can use a custom function that returns the icon for each symbol kind.
--             -- This function takes a kind (string) as parameter and should return an
--             -- icon as string.
--             icon_fetcher = nil,
--             -- 3rd party source for fetching icons. Fallback if icon_fetcher returned
--             -- empty string. Currently supported values: 'lspkind'
--             icon_source = nil,
--             -- The next fallback if both icon_fetcher and icon_source has failed, is
--             -- the custom mapping of icons specified below. The icons table is also
--             -- needed for specifying hl group.
--             icons = {
--                 File = { icon = '󰈔', hl = 'Identifier' },
--                 Module = { icon = '󰆧', hl = 'Include' },
--                 Namespace = { icon = '󰅪', hl = 'Include' },
--                 Package = { icon = '󰏗', hl = 'Include' },
--                 Class = { icon = '𝓒', hl = 'Type' },
--                 Method = { icon = 'ƒ', hl = 'Function' },
--                 Property = { icon = '', hl = 'Identifier' },
--                 Field = { icon = '󰆨', hl = 'Identifier' },
--                 Constructor = { icon = '', hl = 'Special' },
--                 Enum = { icon = 'ℰ', hl = 'Type' },
--                 Interface = { icon = '󰜰', hl = 'Type' },
--                 Function = { icon = '', hl = 'Function' },
--                 Variable = { icon = '', hl = 'Constant' },
--                 Constant = { icon = '', hl = 'Constant' },
--                 String = { icon = '𝓐', hl = 'String' },
--                 Number = { icon = '#', hl = 'Number' },
--                 Boolean = { icon = '⊨', hl = 'Boolean' },
--                 Array = { icon = '󰅪', hl = 'Constant' },
--                 Object = { icon = '⦿', hl = 'Type' },
--                 Key = { icon = '🔐', hl = 'Type' },
--                 Null = { icon = 'NULL', hl = 'Type' },
--                 EnumMember = { icon = '', hl = 'Identifier' },
--                 Struct = { icon = '𝓢', hl = 'Structure' },
--                 Event = { icon = '🗲', hl = 'Type' },
--                 Operator = { icon = '+', hl = 'Identifier' },
--                 TypeParameter = { icon = '𝙏', hl = 'Identifier' },
--                 Component = { icon = '󰅴', hl = 'Function' },
--                 Fragment = { icon = '󰅴', hl = 'Constant' },
--                 TypeAlias = { icon = ' ', hl = 'Type' },
--                 Parameter = { icon = ' ', hl = 'Identifier' },
--                 StaticMethod = { icon = ' ', hl = 'Function' },
--                 Macro = { icon = ' ', hl = 'Function' },
--             },
--         },
--     },
-- }
