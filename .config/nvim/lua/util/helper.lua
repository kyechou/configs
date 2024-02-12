--
-- My own helper functions
--

local helper = {}

-- All Mason packages
helper.mason_packages = {
    'bash-language-server',       -- Bash LSP
    'clang-format',               -- C, C++, C#, JSON, Java, JS formatter
    'clangd',                     -- C, C++ LSP
    'cmake-language-server',      -- CMake LSP
    'codespell',                  -- General linter, spell checker
    'cpptools',                   -- C, C++, Rust DAP
    'css-lsp',                    -- CSS, SCSS, LESS LSP
    'dockerfile-language-server', -- Docker LSP
    'html-lsp',                   -- HTML LSP
    'json-lsp',                   -- JSON LSP
    'ltex-ls',                    -- Text, Markdown, LaTeX LSP
    'lua-language-server',        -- Lua LSP
    'marksman',                   -- Markdown LSP
    'pyright',                    -- Python LSP
    'shellcheck',                 -- Bash linter
    'shfmt',                      -- Shell formatter
    'taplo',                      -- TOML LSP
}

-- Mason language servers
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
helper.mason_lsp_configs = {
    bashls = {},   -- https://github.com/bash-lsp/bash-language-server
    clangd = {},   -- https://clangd.llvm.org/installation.html
    cmake = {},    -- https://github.com/regen100/cmake-language-server
    cssls = {},    -- https://github.com/hrsh7th/vscode-langservers-extracted
    dockerls = {}, -- https://github.com/rcjsuen/dockerfile-language-server
    html = {},     -- https://github.com/hrsh7th/vscode-langservers-extracted
    jsonls = {},   -- https://github.com/hrsh7th/vscode-langservers-extracted
    ltex = {},     -- https://github.com/valentjn/ltex-ls
    lua_ls = {},   -- https://luals.github.io/wiki/settings/
    marksman = {}, -- https://github.com/artempyanykh/marksman
    pyright = {},  -- https://github.com/microsoft/pyright
    taplo = {},    -- https://taplo.tamasfe.dev/cli/usage/language-server.html (TOML)
}

-- Mason debug adapters
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
-- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
helper.mason_dap_configs = {
    cpptools = {}, -- https://github.com/microsoft/vscode-cpptools
}

-- Treesitter language parsers
-- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages
-- https://tree-sitter.github.io/tree-sitter/
helper.ts_language_parsers = {
    'awk',
    'bash',
    'bibtex',
    'c',
    'cmake',
    'comment',
    'cpp',
    'css',
    'csv',
    'diff',
    'dockerfile',
    'dot',
    'git_config',
    'gitcommit',
    'gitignore',
    'go',
    'haskell',
    'html',
    'java',
    'javascript',
    'json',
    'jsonc',
    'latex',
    'lua',
    'make',
    'markdown',
    'ocaml',
    'passwd',
    'proto',
    'python',
    'query',
    'rust',
    'scss',
    'sql',
    'ssh_config',
    'textproto',
    'toml',
    'vim',
    'vimdoc',
    'xml',
    'yaml',
}

-- Return the current buffer's path or cwd if it's not a file.
function helper.find_file_dir_or_cwd()
    local current_file = vim.api.nvim_buf_get_name(0)
    local file_dir
    if current_file == '' then
        -- If the buffer is not associated with a file, use cwd
        file_dir = vim.fn.getcwd()
    else
        -- Extract the directory from the current file's path
        file_dir = vim.fn.fnamemodify(current_file, ':h')
    end
    return file_dir
end

-- Change to the current file's directory. Do nothing if it's not a file.
function helper.cd_to_current_file()
    vim.cmd.chdir(helper.find_file_dir_or_cwd())
    print(vim.fn.getcwd())
end

-- Return the git base directory based on the current buffer's path if it is a
-- git repository. Otherwise, return nil.
function helper.find_git_dir()
    local file_dir = helper.find_file_dir_or_cwd()

    -- Find the git base directory from the current file's path
    local git_dir = vim.fn.systemlist(
        'git -C ' .. vim.fn.escape(file_dir, ' ') ..
        ' rev-parse --show-toplevel')[1]
    ---@diagnostic disable-next-line: undefined-field
    if vim.v.shell_error ~= 0 then
        return nil
    end
    return git_dir
end

-- Return the git base directory based on the current buffer's path if it is a
-- git repository. Otherwise, return the current working directory.
function helper.find_git_dir_or_cwd()
    local dir = helper.find_git_dir()
    if dir then
        return dir
    end
    return vim.fn.getcwd()
end

-- List workspace folders
function helper.list_workspace_folders()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

return helper
