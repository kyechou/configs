--
-- https://github.com/David-Kunz/gen.nvim
--

return {
    'David-Kunz/gen.nvim',
    config = function()
        require('gen').setup({
            model = 'llama3.1',                -- The default model to use.
            quit_map = 'q',                    -- close the response window
            retry_map = '<C-r>',               -- re-send the current prompt
            accept_map = '<C-CR>',             -- replace the previous selection with the last result
            host = 'localhost',                -- The host running the Ollama service.
            port = '11434',                    -- The port on which the Ollama service is listening.
            display_mode = 'horizontal-split', -- The display mode. Can be 'float' or 'split' or 'horizontal-split'.
            show_prompt = true,                -- Shows the prompt submitted to Ollama.
            show_model = true,                 -- Displays which model you are using at the beginning of your chat session.
            no_auto_close = true,              -- Never closes the window automatically.
            hidden = false,                    -- Hide the generation window
            init = nil,                        -- Function to initialize Ollama
            -- list_models = '<omitted lua function>', -- Retrieves a list of model names
            debug = false                      -- Prints errors and the command which is run.
        })
    end,
}
