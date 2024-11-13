return {
    {
        'folke/trouble.nvim',
        opts = {}, -- for default options, refer to the configuration section for custom setup.
        cmd = 'Trouble',
        keys = {
            {
                '<leader>ee',
                '<cmd>Trouble diagnostics toggle focus=true<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>eE',
                '<cmd>Trouble diagnostics toggle filter.buf=0 focus=true <cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>es',
                '<cmd>Trouble symbols toggle focus=true win.position=bottom<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>el',
                '<cmd>Trouble lsp toggle focus=true win.position=bottom<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>eL',
                '<cmd>Trouble loclist toggle<cr> focus=true win.position=bottom',
                desc = 'Location List (Trouble)',
            },
            {
                '<leader>eq',
                '<cmd>Trouble qflist toggle<cr> focus=true win.position=bottom',
                desc = 'Quickfix List (Trouble)',
            },
        },
    },
}
