-- ===============================================================
-- ================== My neovim config - kyc  ====================
-- ===============================================================

--
-- Set <space> as the leader key.
-- This must be set before plugins are required.
--
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--
-- Vim settings
-- :help vim.o
--
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 20
vim.g.netrw_browse_split = 3
vim.o.autochdir = false
vim.o.background = 'dark'
vim.o.breakindent = true
vim.o.cindent = true
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.colorcolumn = '+1,121'
vim.o.complete = '.,w,b,u,i,d,t'
vim.o.completeopt = 'menuone,preview'
vim.o.cursorline = true
vim.o.diffopt = 'internal,filler,closeoff,algorithm:minimal'
vim.o.expandtab = true
vim.o.fileencodings = 'ucs-bom,utf-8,big5,gdk,utf-16,utf-16le,default,latin1'
vim.o.fileformats = 'unix,dos,mac'
vim.o.formatoptions = 'tcqnvB1]j' -- fo-table
vim.o.guicursor = 'a:block'
vim.o.ignorecase = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.scrolloff = 3
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,terminal,winpos,winsize'
vim.o.shada = '!,\'100,<50,s20,h'
vim.o.shiftwidth = 4
vim.o.showtabline = 2
vim.o.sidescroll = 1
vim.o.signcolumn = 'yes' -- Avoid gitsigns moving the columns
vim.o.smartcase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spelllang = 'en_us'
vim.o.spelloptions = 'camel,noplainbuffer'
vim.o.splitbelow = false -- Split up
vim.o.splitright = true  -- Split right
vim.o.tabstop = 4
vim.o.termguicolors = true
vim.o.textwidth = 80
vim.o.timeoutlen = 500  -- milliseconds
vim.o.title = true
vim.o.updatetime = 2000 -- milliseconds
vim.o.wildignorecase = true
vim.o.wildmode = 'longest:full,full'

--
-- Plugins
--
require('lazy_init')
require('lazy').setup({
    -- Color themes
    { import = 'color.kanagawa' },
    -- Syntax
    { import = 'syntax.pkgbuild' },     -- PKGBUILD
    { import = 'syntax.click' },        -- Click
    { import = 'syntax.p4' },           -- P4
    { import = 'syntax.promela' },      -- Promela
    { import = 'syntax.systemtap' },    -- SystemTap
    { import = 'syntax.hugo' },         -- Hugo (html/markdown)
    -- UI
    { import = 'ui.lualine' },          -- statusline
    { import = 'ui.bufferline' },       -- tabline
    { import = 'ui.indent_blankline' }, -- Indent line
    { import = 'ui.virt_column' },      -- Color column as a virtual text
    { import = 'ui.gitsigns' },         -- Git integration for buffers
    { import = 'ui.todo' },             -- Todo comments
    { import = 'ui.fold' },             -- UFO, ultra fold in neovim
    { import = 'ui.illuminate' },       -- Illuminate word under cursor
    { import = 'ui.css_color' },        -- CSS colors
    -- Utility
    { import = 'util.which_key' },      -- Show pending keybindings
    { import = 'util.vim_sleuth' },     -- Auto-adjust tabstop, shiftwidth, etc.
    { import = 'util.autopairs' },      -- Auto-pairs
    { import = 'util.comment' },        -- Comment
    { import = 'util.terminal' },       -- Terminal toggle
    { import = 'util.undo' },           -- Undo closing tabs
    { import = 'util.telescope' },      -- Fuzzy finder
    { import = 'util.session' },        -- Session management
    { import = 'util.nvim_tree' },      -- File tree
    { import = 'util.documentation' },  -- Documentation generation
    { import = 'util.mason_packages' }, -- Manage mason packages
    -- LSP, DAP, Linters, Formatters
    { import = 'util.fidget' },         -- LSP progress messages
    { import = 'util.lspconfig' },      -- Configurations for LSP clients
    { import = 'util.dap' },            -- Debug support with DAPs
    { import = 'util.cmp' },            -- Autocomplete with LSP and snippets
    { import = 'util.treesitter' },     -- Highlight, edit, and navigate code
    { import = 'util.trouble' },        -- Pretty diagnostics and others
    { import = 'util.outline' },        -- Code outline sidebar
    { import = 'util.shfmt' },          -- Shell formatting
    { import = 'util.latex' },          -- Better LaTeX support
    { import = 'util.ai' },             -- AI assistants
}, {
    defaults = { version = '*' }        -- Latest stable version
})

vim.cmd.colorscheme('kanagawa')

--
-- Key mappings
-- :help vim.keymap.set()
--

-- Document existing key chains.
require('which-key').add({
    { '<leader>c', group = '[C]hange' },
    { '<leader>d', group = '[D]iagnostics/[D]ocumentation' },
    { '<leader>g', group = '[G]it' },
    { '<leader>l', group = '[L]aTeX' },
    { '<leader>p', group = '[P]rompt/GenAI',               mode = { 'n', 'v' } },
    { '<leader>r', group = '[R]ename' },
    { '<leader>w', group = '[W]orkspace' },
    { '<leader>',  group = 'VISUAL <leader>',              mode = 'v' },
    { '<leader>g', desc = '[G]it hunk',                    mode = 'v' },
})

local helper = require('util.helper')
local builtin = require('telescope.builtin')
local illum = require('illuminate')
local gitsigns = package.loaded.gitsigns

-- Reset key mappings
vim.keymap.set('n', '<CR>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Navigation
vim.keymap.set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '0', "v:count == 0 ? 'g0' : '0'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '$', "v:count == 0 ? 'g$' : '$'", { expr = true, silent = true })
vim.keymap.set('n', '<C-\\>', ':vs<CR>', { silent = true, desc = 'Vertical split' })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { silent = true, desc = 'Move down the selected text' })
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { silent = true, desc = 'Move up the selected text' })
vim.keymap.set('n', '<C-s>', TLSCP_live_grep_in_git_or_cwd, { desc = 'Search in git repo or cwd' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Search in current buffer' })
vim.keymap.set('n', '<leader>cd', helper.cd_to_current_file, { silent = true, desc = 'Change to current directory' })
vim.keymap.set('n', ']r', illum.goto_next_reference, { silent = true, desc = 'Go to next reference' })
vim.keymap.set('n', '[r', illum.goto_prev_reference, { silent = true, desc = 'Go to previous reference' })
-- Files
vim.keymap.set('n', '<C-a>', ':ClangdSwitchSourceHeader<CR>', { silent = true, desc = 'Switch hdr/src' })
vim.keymap.set('n', '<C-e>', TLSCP_find_files_from_git_or_cwd, { desc = 'Find files' })
vim.keymap.set('n', '<C-S-e>', TLSCP_find_ignored_files_from_git_or_cwd, { desc = 'Find ignored files' })
vim.keymap.set('n', '<leader>e', TLSCP_find_ignored_files_from_git_or_cwd, { desc = 'Find ignored files' })
vim.keymap.set('n', '<C-f>', NVT_toggle, { silent = true, desc = 'File browser' })
-- Tabs / Buffers
vim.keymap.set('n', 't', ':tabnew ', { desc = 'Create a new tab' })
vim.keymap.set('n', 'yt', ':tab split<CR>', { silent = true, desc = 'Duplicate tab' })
vim.keymap.set('n', '<C-k>', ':tabclose<CR>', { silent = true, desc = 'Close tab' })
vim.keymap.set('n', '<C-l>', ':tabnext<CR>', { silent = true, desc = 'Switch to next tab' })
vim.keymap.set('n', '<C-h>', ':tabprev<CR>', { silent = true, desc = 'Switch to previous tab' })
vim.keymap.set('n', '<C-Right>', ':tabmove +1<CR>', { silent = true, desc = 'Move tab to right' })
vim.keymap.set('n', '<C-Left>', ':tabmove -1<CR>', { silent = true, desc = 'Move tab to left' })
vim.keymap.set('n', '<C-S-t>', ':LastBuf<CR>', { desc = 'Reopen last buffer' })
vim.keymap.set('n', '<leader>u', ':LastBuf<CR>', { desc = 'Reopen last buffer' })
vim.keymap.set('n', '<C-S-k>', helper.del_windowless_bufs, { desc = 'Delete windowless buffers (caution!)' })
vim.keymap.set('n', '<leader>k', helper.del_windowless_bufs, { desc = 'Delete windowless buffers (caution!)' })
vim.keymap.set('n', '<leader><space>', TLSCP_list_buffers, { desc = 'List buffers' })
-- UI
vim.keymap.set('n', '<C-n>', ':noh<CR>', { silent = true, desc = 'Disable search highlights' })
-- Shell / Commands
vim.keymap.set('n', 'r', ':! ', { desc = 'Run shell commands' })
vim.keymap.set({ 'n', 'i' }, '<C-CR>', TERM_toggle_float, { silent = true, desc = 'Terminal (float)' })
vim.keymap.set('n', '<leader><CR>', TERM_toggle_float, { silent = true, desc = 'Terminal (float)' })
vim.keymap.set({ 'n', 'i' }, '<C-j>', TERM_toggle_bottom, { silent = true, desc = 'Terminal (bottom)' })
vim.keymap.set('t', '<C-CR>', TERM_toggle_float, { silent = true, desc = 'Terminal (float)' })
vim.keymap.set('t', '<C-j>', TERM_toggle_bottom, { silent = true, desc = 'Terminal (bottom)' })
vim.keymap.set('n', '<leader>:', builtin.commands, { desc = 'Run commands' })
vim.keymap.set('n', '<C-p>', builtin.command_history, { desc = 'Command history' })
-- Comments
local capi = require('Comment.api')
vim.keymap.set('n', '<C-/>', capi.toggle.linewise.current, { desc = 'Toggle comment' })
vim.keymap.set('v', '<C-/>', capi.call('toggle.linewise', 'g@'), { expr = true, desc = 'Toggle comment' })
vim.keymap.set('n', '<C-_>', capi.toggle.linewise.current, { desc = 'Toggle comment' })
vim.keymap.set('v', '<C-_>', capi.call('toggle.linewise', 'g@'), { expr = true, desc = 'Toggle comment' })
vim.keymap.set({ 'n', 'v' }, '<C-c>', capi.call('toggle.linewise', 'g@'), { expr = true, desc = 'Comment operator' })
vim.keymap.set('n', '<C-c>O', capi.insert.linewise.above, { desc = 'Insert a comment above' })
vim.keymap.set('n', '<C-c>o', capi.insert.linewise.below, { desc = 'Insert a comment below' })
vim.keymap.set('n', '<C-c>A', capi.insert.linewise.eol, { desc = 'Insert a comment at end of line' })
-- Todo
vim.keymap.set('n', ']t', TODO_jump_next, { desc = 'Next todo comment' })
vim.keymap.set('n', '[t', TODO_jump_prev, { desc = 'Previous todo comment' })
vim.keymap.set('n', ']T', TODO_jump_next_issue, { desc = 'Next issue' })
vim.keymap.set('n', '[T', TODO_jump_prev_issue, { desc = 'Previous issue' })
vim.keymap.set('n', '<leader>t', ':TodoTelescope<CR>', { desc = 'Todo comments' })
-- LSP
vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, { desc = 'LSP: Signature help' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: Hover documentation' })
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'LSP: References' })
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = 'LSP: Definition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: Declaration' })
vim.keymap.set('n', 'gi', builtin.lsp_implementations, { desc = 'LSP: Implementation' })
vim.keymap.set('n', 'gs', builtin.lsp_dynamic_workspace_symbols, { desc = 'LSP: Symbols' })
vim.keymap.set('n', 'gS', builtin.lsp_document_symbols, { desc = 'LSP: Symbols in the current buffer' })
vim.keymap.set('n', 'gI', builtin.lsp_incoming_calls, { desc = 'LSP: Incoming calls' })
vim.keymap.set('n', 'gO', builtin.lsp_outgoing_calls, { desc = 'LSP: Outcoming calls' })
vim.keymap.set('n', '<leader>o', ':AerialToggle!<CR>', { desc = 'Outline' })
vim.keymap.set('n', '<leader>O', ':AerialToggle<CR>', { desc = 'Outline (switch focus)' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP: Rename symbol' })
vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { desc = 'LSP: Code actions' })
-- Diagnostics
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>ds', TLSCP_diagnostics, { desc = 'Search diagnostics' })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = 'Diagnostic message' })
vim.keymap.set('n', '<leader>dd', ':Trouble diagnostics toggle<CR>', { desc = 'Trouble: Diagnostics' })
vim.keymap.set('n', '<leader>dl', ':Trouble loclist toggle<CR>', { desc = 'Trouble: Location list' })
vim.keymap.set('n', '<leader>dq', ':Trouble quickfix toggle<CR>', { desc = 'Trouble: Quickfix' })
vim.keymap.set('n', '<leader>s', ':setlocal spell!<CR>', { desc = 'Spell check' })
-- Documentation
vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = 'Help' })
vim.keymap.set('n', '<leader>m', TLSCP_man_pages, { desc = 'Man pages' })
vim.keymap.set('n', '<leader>dg', NEOGEN_any, { desc = 'Generate documentation' })
vim.keymap.set('n', '<leader>df', NEOGEN_function, { desc = 'Generate function documentation' })
vim.keymap.set('n', '<leader>dc', NEOGEN_class, { desc = 'Generate class documentation' })
vim.keymap.set('n', '<leader>dt', NEOGEN_type, { desc = 'Generate type documentation' })
vim.keymap.set('n', '<leader>dF', NEOGEN_file, { desc = 'Generate file documentation' })
-- Git
vim.keymap.set({ 'n', 'v' }, ']h', function() GS_next_hunk(']h') end, { desc = 'Jump to next hunk' })
vim.keymap.set({ 'n', 'v' }, '[h', function() GS_prev_hunk('[h') end, { desc = 'Jump to previous hunk' })
vim.keymap.set('n', '<leader>gs', TLSCP_git_status, { desc = 'Git status' })
vim.keymap.set('n', '<leader>gc', TLSCP_git_commits, { desc = 'Show git commits' })
vim.keymap.set('v', '<leader>ga', GS_v_stage_hunk, { desc = 'Add git hunk' })
vim.keymap.set('n', '<leader>ga', gitsigns.stage_hunk, { desc = 'Add git hunk' })
vim.keymap.set('v', '<leader>gr', GS_v_reset_hunk, { desc = 'Reset/discard git hunk' })
vim.keymap.set('n', '<leader>gr', gitsigns.reset_hunk, { desc = 'Reset/discard git hunk' })
vim.keymap.set('n', '<leader>gu', gitsigns.undo_stage_hunk, { desc = 'Undo add/stage hunk' })
vim.keymap.set('n', '<leader>gA', gitsigns.stage_buffer, { desc = 'Git add/stage buffer' })
vim.keymap.set('n', '<leader>gR', gitsigns.reset_buffer, { desc = 'Git reset buffer' })
vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, { desc = 'Preview git hunk' })
vim.keymap.set('n', '<leader>gd', gitsigns.diffthis, { desc = 'Diff against index (working tree)' })
vim.keymap.set('n', '<leader>gD', function() gitsigns.diffthis('~') end, { desc = 'Diff against last commit' })
vim.keymap.set('n', '<leader>gb', GS_blame_line, { desc = 'Git blame' })
-- Workspace / Session
vim.keymap.set('n', '<leader>wl', require('auto-session.session-lens').search_session, { desc = 'List sessions' })
vim.keymap.set('n', '<leader>ws', ':SessionSave<CR>', { desc = 'Save session' })
vim.keymap.set('n', '<leader>wd', ':SessionDelete<CR>', { desc = 'Delete session' })
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'Workspace: Add foler' })
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'Workspace: Remove folder' })
vim.keymap.set('n', '<leader>wf', helper.list_workspace_folders, { desc = 'Workspace: Folders' })
-- GenAI / Prompt
require('gen').prompts['Review_Code'] = {
    prompt = "Improve the following code and make concise suggestions:\n\n$text",
    replace = false,
}
require('gen').prompts['Improve_Writing'] = {
    prompt = "Improve the following text to make it better and concise without losing any points:\n\n$text",
    replace = false,
}
vim.keymap.set({ 'n', 'v' }, '<leader>pm', require('gen').select_model, { desc = 'Gen: Select model' })
vim.keymap.set({ 'n', 'v' }, '<leader>pp', ':Gen<CR>', { desc = 'Gen: Choose prompt' })
vim.keymap.set({ 'n', 'v' }, '<leader>pc', ':Gen Chat<CR>', { desc = 'Gen: Talk/Chat' })
vim.keymap.set({ 'n', 'v' }, '<leader>pa', ':Gen Ask<CR>', { desc = 'Gen: Ask about the provided text' })
vim.keymap.set({ 'n', 'v' }, '<leader>ps', ':Gen Summarize<CR>', { desc = 'Gen: Summarize the provided text' })
vim.keymap.set({ 'n', 'v' }, '<leader>pr', ':Gen Review_Code<CR>', { desc = 'Gen: Review code' })
vim.keymap.set({ 'n', 'v' }, '<leader>pw', ':Gen Improve_Writing<CR>', { desc = 'Gen: Improve writing' })
-- Debug
local dap = require('dap')
local dapui = require('dapui')
vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<F6>', dap.toggle_breakpoint, { desc = 'Debug: Toggle breakpoint' })
vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: Toggle debug UI' })
vim.keymap.set({ 'n', 'v' }, '<F8>', dapui.eval, { desc = 'Debug: Evaluate expression' })

--
-- Autocommands
--
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*.sh', '*.bash' },
    command = 'Shfmt', -- require 'z0mbix/vim-shfmt' (util/shfmt.lua)
    desc = 'Auto-format shell scripts',
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    pattern = { '*' },
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        pcall(function() vim.cmd([[%s/\s\+$//e]]) end)
        vim.fn.setpos(".", save_cursor)
    end,
    desc = 'Auto-remove trailing whitespaces for LaTeX files',
})
-- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
--     pattern = { '*.maude' },
--     command = 'set syntax=maude filetype=maude',
--     desc = 'Set .maude file type as maude',
-- })
-- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
--     pattern = { '*.click' },
--     command = 'set syntax=click filetype=click',
--     desc = 'Set .click file type as click',
-- })

-- vim: ts=4 sw=4 et :
