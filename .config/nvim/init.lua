-- ===============================================================
-- ================== My neovim config - kyc  ====================
-- ===============================================================

--
-- Set <space> as the leader key.
-- This must be set before plugins are required (otherwise wrong leader will be used).
--
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--
-- Vim settings
-- `:help vim.o`
--
vim.o.autochdir = false
vim.o.background = 'dark'
vim.o.breakindent = true
vim.o.browsedir = 'last'
vim.o.cindent = true
vim.o.clipboard = 'unnamed,unnamedplus'
vim.o.colorcolumn = 81
vim.o.complete = '.,w,b,u,i,d,t'
vim.o.completeopt = 'menuone,preview'
vim.o.cursorline = true
vim.o.diffopt = 'internal,filler,closeoff,algorithm:patience'
vim.o.expandtab = true
vim.o.fileencodings = 'ucs-bom,utf-8,big5,gdk,utf-16,utf-16le,default,latin1'
vim.o.fileformats = 'unix,dos,mac'
vim.o.formatoptions = 'tcqnvmB1]j'
vim.o.guicursor = 'a:block'
vim.o.ignorecase = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.scrolloff = 5
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,localoptions,options,tabpages,terminal,winsize'
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
    { import = 'color.onedark' },
    { import = 'color.catppuccin' },
    -- UI
    { import = 'ui.lualine' },                -- statusline
    { import = 'ui.bufferline' },             -- tabline
    { import = 'ui.indent_blankline' },       -- Indent line
    { import = 'ui.gitsigns' },               -- Git integration for buffers
    { import = 'ui.css_color' },              -- CSS colors
    -- Syntax
    { import = 'syntax/click' },              -- Click
    { import = 'syntax/p4' },                 -- P4
    { import = 'syntax/promela' },            -- Promela
    -- Utility
    { import = 'util.fidget' },               -- LSP progress messages
    { import = 'util.mason_tool_installer' }, -- Manage mason packages
    { import = 'util.lspconfig' },            -- Configurations for LSP clients
    { import = 'util.dap' },                  -- Debug support with DAPs
    { import = 'util.cmp' },                  -- Autocomplete with LSP and snippets
    { import = 'util.vim_sleuth' },           -- Automatically infer tabstop, shiftwidth, etc.
    { import = 'util.which_key' },            -- Show pending keybindings
    { import = 'util.autopairs' },            -- Auto-pairs
    { import = 'util.comment' },              -- Comment
    { import = 'util.telescope' },            -- Fuzzy finder

    -- TODO: Set up treesitter
    -- { import = 'util.treesitter' },

    -- Plugins to add --
    -- https://github.com/vigoux/ltex-ls.nvim (Client-side plugin: needed for the dictionary stuff)
    -- git-blame.nvim
    -- harpoon
    -- trouble
    -- https://github.com/folke/todo-comments.nvim
    -- https://github.com/hedyhli/outline.nvim
    -- https://github.com/lervag/vimtex, if lsp is not good enough
    -- Session management
    -- https://github.com/rmagatti/auto-session
    -- https://github.com/rmagatti/session-lens

    -- Old plugins (find a better alternative if it's still needed)
    -- Plug 'mileszs/ack.vim'
    -- Plug 'craigemery/vim-autotag'
    -- Plug 'vim-scripts/taglist.vim'

    -- sonarlint (optional)
    -- https://github.com/MuriloGhignatti/nvim-config/blob/2229c3/lua/safe/plugins/lsp/linter.lua
    -- https://www.reddit.com/r/neovim/comments/14a4y3y/sonarlint/

}, {
    defaults = { version = '*' } -- Latest stable version
})

vim.cmd.colorscheme('catppuccin')
require('util.telescope_keymaps')

-- TODO: Update this
-- Document existing key chains.
require('which-key').register({
    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    ['<leader>d'] = { name = '[D]iagnostics', _ = 'which_key_ignore' },
    ['<leader>f'] = { name = '[F]iles', _ = 'which_key_ignore' },
    ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
    ['<leader>h'] = { name = '[H]elp', _ = 'which_key_ignore' },
    ['<leader>m'] = { name = '[M]an pages', _ = 'which_key_ignore' },
    ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
    ['<leader>s'] = { name = '[S]earch text', _ = 'which_key_ignore' },
    -- ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
    ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
})

-- Required for visual <leader>hs (hunk stage) to work.
require('which-key').register({
    ['<leader>'] = { name = 'VISUAL <leader>' },
    ['<leader>h'] = { 'Git [H]unk' },
}, { mode = 'v' })

--
-- Key mappings
-- `:help vim.keymap.set()`
--
-- Leader notes:
--   - <leader> f : Find files
--   - <leader> d : Diagnostic
--   - <leader> w : Workspace (tentative)
--   - <leader> rn : rename symbol
--   - <leader> ca : code action
--   - <leader> h : help
--   - <leader> m : man pages
--   - <leader> g : git

-- scripts that have key mappings
-- gitsigns, treesitter

local helper = require('util.helper')
local builtin = require('telescope.builtin')
local gitsigns = package.loaded.gitsigns

-- Navigation
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '0', "v:count == 0 ? 'g0' : '0'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '$', "v:count == 0 ? 'g$' : '$'", { expr = true, silent = true })
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set('n', '<leader>cd', helper.cd_to_current_file, { silent = true })
-- Comment: <C-c>, <C-/>
-- UI
vim.keymap.set('n', '<C-n>', ':noh<CR>', { silent = true, desc = 'Disable search highlights' })
-- TODO: treesitter here.
-- nnoremap <leader>n :Lexplore<CR> -- netrw tree
--builtin.treesitter()
-- Shell / Commands
vim.keymap.set('n', 'r', ':! ', { desc = 'Run shell commands' })
vim.keymap.set('n', '<C-j>', ':botright split +term<CR>', { silent = true, desc = 'Create a shell' })
vim.keymap.set('n', '<leader>:', builtin.commands, { desc = 'Run commands' })
vim.keymap.set('n', '<C-p>', builtin.command_history, { desc = 'Command history' })
vim.keymap.set('n', '<C-m>', ':Mason<CR>', { desc = 'Open Mason' })
-- Tabs / Buffers
vim.keymap.set('n', 't', ':tabnew ', { desc = 'Create a new tab' })
vim.keymap.set('n', 'yt', ':tab split<CR>', { silent = true, desc = 'Duplicate tab' })
vim.keymap.set('n', '<C-k>', ':tabclose<CR>', { silent = true, desc = 'Close tab' })
vim.keymap.set('n', '<C-l>', ':tabnext<CR>', { silent = true, desc = 'Switch to next tab' })
vim.keymap.set('n', '<C-h>', ':tabprev<CR>', { silent = true, desc = 'Switch to previous tab' })
vim.keymap.set('n', '<C-Right>', ':tabmove +1<CR>', { silent = true, desc = 'Move tab to right' })
vim.keymap.set('n', '<C-Left>', ':tabmove -1<CR>', { silent = true, desc = 'Move tab to left' })
vim.keymap.set('n', '<leader><space>', TLSCP_list_buffers, { desc = 'List buffers' })
-- Files
vim.keymap.set('n', '<C-a>', ':ClangdSwitchSourceHeader<CR>', { silent = true, desc = 'Switch hdr/src' })
vim.keymap.set('n', '<C-e>', TLSCP_find_git_files_or_from_cwd, { desc = 'Find files' })
vim.keymap.set('n', '<leader>ff', TLSCP_find_git_files_or_from_cwd, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fr', builtin.oldfiles, { desc = '[F]ind [R]ecently opened files' })
-- Search / Grep
vim.keymap.set('n', '<C-s>', TLSCP_live_grep_in_git_or_cwd, { desc = 'Search in git repo or cwd' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Search in current buffer' })
-- vim.keymap.set('n', '<leader>so', TLSCP_live_grep_open_files, { desc = '[S]earch in [O]pen files' })
-- Diagnostic (TODO: wait for trouble)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>d', TLSCP_diagnostics, { desc = 'Search diagnostics' })
-- vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = 'Open [D]iagnostic [M]essage' })
-- vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open [D]iagnostics [L]ist' })
vim.keymap.set('n', '<leader>s', ':setlocal spell!<CR>', { desc = 'Toggle spell check' })
-- LSP
vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, { desc = 'LSP: Signature help' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: Hover documentation' })
vim.keymap.set('n', 'gr', builtin.lsp_references, { desc = 'LSP: [G]oto [R]eferences' })
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { desc = 'LSP: [G]oto [D]efinition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'LSP: [G]oto [D]eclaration' })
vim.keymap.set('n', 'gi', builtin.lsp_implementations, { desc = 'LSP: [G]oto [I]mplementation' })
vim.keymap.set('n', 'gs', builtin.lsp_dynamic_workspace_symbols, { desc = 'LSP: [G]oto [S]ymbols' })
vim.keymap.set('n', 'gS', builtin.lsp_document_symbols, { desc = 'LSP: [G]oto document [S]ymbols' })
-- keymap 'gt': tags, outlines
-- nnoremap <leader>t :TlistToggle<CR> -- tag list
vim.keymap.set('n', '<F2>', vim.lsp.buf.rename, { desc = 'LSP: Rename symbol' })
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP: [R]e[n]ame symbol' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'LSP: [C]ode [A]ction' })
-- Workspace / Session (TODO: wait for session management)
vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, { desc = 'LSP: [W]orkspace [A]dd foler' })
vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, { desc = 'LSP: [W]orkspace [R]emove folder' })
vim.keymap.set('n', '<leader>wl', helper.list_workspace_folders, { desc = 'LSP: [W]orkspace [L]ist folders' })
-- Documentation
vim.keymap.set('n', '<leader>h', builtin.help_tags, { desc = '[H]elp' })
vim.keymap.set('n', '<leader>m', TLSCP_man_pages, { desc = '[M]an pages' })
-- Git
vim.keymap.set({ 'n', 'v' }, ']h', function() GS_next_hunk(']h') end, { desc = 'Jump to next hunk' })
vim.keymap.set({ 'n', 'v' }, '[h', function() GS_prev_hunk('[h') end, { desc = 'Jump to previous hunk' })
vim.keymap.set('n', '<leader>gs', TLSCP_git_status, { desc = 'Git status' })
-- vim.keymap.set('n', '<leader>gb', TLSCP_git_branches, { desc = 'Git branch' })
vim.keymap.set('n', '<leader>gc', TLSCP_git_commits, { desc = 'Git commit' })
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
vim.keymap.set('n', '<leader>gb', gitsigns.blame_line, { desc = 'Git blame line' }) -- TODO: git blame
-- Debug
local dap = require('dap')
local dapui = require('dapui')
vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle breakpoint' })
vim.keymap.set('n', '<leader>B', DAP_set_conditional_bp, { desc = 'Debug: Set conditional breakpoint' })
vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: Toggle debug UI' })
vim.keymap.set({ 'n', 'v' }, '<F8>', dapui.eval, { desc = 'Debug: Evaluate expression' })

--
-- Autocommands
--
vim.api.nvim_create_autocmd('TermOpen', {
    command = 'startinsert',
    desc = 'Start insert mode upon opening terminals'
})
-- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
--     pattern = { '*.h' },
--     command = 'set syntax=cpp filetype=cpp',
--     desc = 'Set .h file type as C++',
-- })
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
