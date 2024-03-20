--
-- https://github.com/danymat/neogen
--

return {
    'danymat/neogen',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    config = function()
        require('neogen').setup({
            enabled = true,             -- enable/disable Neogen
            input_after_comment = true, -- (default: true)
            snippet_engine = 'luasnip',
            languages = {
                sh = {
                    template = {
                        annotation_convention = 'google_bash',
                    },
                },
                c = {
                    template = {
                        annotation_convention = 'doxygen',
                    },
                },
                cpp = {
                    template = {
                        annotation_convention = 'doxygen',
                    },
                },
                python = {
                    template = {
                        annotation_convention = 'google_docstrings',
                    },
                },
            },
        })

        -- Generate documentation for the current position.
        function NEOGEN_any()
            require('neogen').generate({ type = 'any' })
        end

        -- Generate documentation for the current function.
        function NEOGEN_function()
            require('neogen').generate({ type = 'func' })
        end

        -- Generate documentation for the current class.
        function NEOGEN_class()
            require('neogen').generate({ type = 'class' })
        end

        -- Generate documentation for the current type.
        function NEOGEN_type()
            require('neogen').generate({ type = 'type' })
        end

        -- Generate documentation for the current file.
        function NEOGEN_file()
            require('neogen').generate({ type = 'file' })
        end
    end,
}
