return {
    {
        'folke/trouble.nvim',
        cmd = 'Trouble',
        opts = {
            focus = true,
            modes = {
                -- sources define their own modes, which you can use directly,
                -- or override like in the example below
                lsp_references = {
                    -- some modes are configurable, see the source code for more details
                    params = {
                        include_declaration = true,
                        include_current = true,
                    },
                },
                lsp_definitions = {
                    -- some modes are configurable, see the source code for more details
                    params = {
                        include_current = true,
                    },
                },
                -- The LSP base mode for:
                -- * lsp_definitions, lsp_references, lsp_implementations
                -- * lsp_type_definitions, lsp_declarations, lsp_command
                lsp_base = {
                    params = {
                        -- include the current location in the results
                        include_current = true,
                    },
                },
                -- more advanced example that extends the lsp_document_symbols
                symbols = {
                    desc = "document symbols",
                    mode = "lsp_document_symbols",
                    focus = true,
                    win = { position = "right" },
                    filter = {
                        -- remove Package since luals uses it for control flow structures
                        ["not"] = { ft = "lua", kind = "Package" },
                        any = {
                            -- all symbol kinds for help / markdown files
                            ft = { "help", "markdown" },
                            -- default set of symbol kinds
                            kind = {
                                "Class",
                                "Constructor",
                                "Enum",
                                "Field",
                                "Function",
                                "Interface",
                                "Method",
                                "Module",
                                "Namespace",
                                "Package",
                                "Property",
                                "Struct",
                                "Trait",
                            },
                        },
                    },
                },
            },
        }, -- for default options, refer to the configuration section for custom setup.
        keys = {
            {
                '<leader>ee',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>eE',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>es',
                '<cmd>Trouble symbols toggle<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>el',
                '<cmd>Trouble lsp toggle  win.position=bottom<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>eL',
                '<cmd>Trouble loclist toggle<cr>  win.position=bottom',
                desc = 'Location List (Trouble)',
            },
            {
                '<leader>eq',
                '<cmd>Trouble qflist toggle<cr>  win.position=bottom',
                desc = 'Quickfix List (Trouble)',
            },
        },
    },
}
