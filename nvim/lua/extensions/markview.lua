return {
    -- Beautiful Markdown Renderer (like conceallevel = 3 but on steroids)
    {
        'OXY2DEV/markview.nvim',
        ft = 'markdown',
        dependencies = {
            -- You may not need this if you don't lazy load
            -- Or if the parsers are in your $RUNTIMEPATH
            'nvim-treesitter/nvim-treesitter',

            'nvim-tree/nvim-web-devicons',
        },
        opts = {
            -- Buffer types to ignore
            buf_ignore = { "nofile" },
            -- Delay, in miliseconds
            -- to wait before a redraw occurs(after an event is triggered)
            debounce = 50,
            -- Filetypes where the plugin is enabled
            filetypes = { "markdown", "quarto", "rmd" },
            -- Highlight groups to use
            -- "dynamic" | "light" | "dark"
            highlight_groups = "dynamic",
            -- Modes where hybrid mode is enabled
            hybrid_modes = nil,
            -- Tree-sitter query injections
            -- injections = {},
            -- Initial plugin state,
            -- true = show preview
            -- falss = don't show preview
            initial_state = true,
            -- Max file size that is rendered entirely
            max_file_length = 1000,
            -- Modes where preview is shown
            modes = { "n", "no", "c" },
            -- Lines from the cursor to draw when the
            -- file is too big
            render_distance = 100,
            -- Window configuration for split view
            split_conf = {},

            -- Rendering related configuration
            block_quotes = {},
            callbacks = {},
            checkboxes = {},
            code_blocks = {},
            escaped = {},
            footnotes = {},
            headings = {},
            horizontal_rules = {},
            html = {},
            inline_codes = {},
            latex = {},
            links = {},
            list_items = {},
            tables = {},
            callback = {
                on_enable = function(_, win)
                    vim.wo[win].conceallevel = 2
                    vim.wo[win].concealcursor = 'nc'
                end,
                -- on_disable = function(_, win)
                --   vim.wo[win].conceallevel = 0
                -- end,
            },
        },
        keys = {
            { '<leader>um', '<cmd>Markview<cr>', desc = 'MD: Toggle [m]arkdown View' },
        },
    },
}
