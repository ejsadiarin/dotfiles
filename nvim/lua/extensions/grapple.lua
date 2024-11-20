return {
    {
        'cbochs/grapple.nvim',
        dependencies = {
            { 'nvim-tree/nvim-web-devicons', lazy = true },
        },
        opts = {
            scope = 'git',
            default_scopes = {
                git = { shown = true },
                global = { shown = true },
                git_branch = { shown = true },
                cwd = { shown = true },
                lsp = { shown = true },
                static = { shown = true },
            },
            statusline = { -- for statusline lualine module only
                icon = '󰛢',
                active = '|%s|',
                inactive = ' %s ',
            },
        },
        event = { 'BufReadPost', 'BufNewFile' },
        cmd = 'Grapple',
        keys = {
            { '<leader>a', '<cmd>Grapple toggle<cr>',            desc = 'Grapple: toggle tag' },
            { '<leader>h', '<cmd>Grapple toggle_tags<cr>',       desc = 'Grapple: open tags window' },
            { '<S-l>',     '<cmd>Grapple cycle_tags next<cr>',   desc = 'Grapple cycle next tag' },
            { '<S-h>',     '<cmd>Grapple cycle_tags prev<cr>',   desc = 'Grapple cycle previous tag' },
            { '<leader>.', '<cmd>Grapple cycle_scopes next<cr>', desc = 'Grapple cycle next scope' },
            { '<leader>,', '<cmd>Grapple cycle_scopes prev<cr>', desc = 'Grapple cycle previous scope' },
            { '<leader>1', '<cmd>Grapple select index=1<cr>',    desc = 'which_key_ignore' },
            { '<leader>2', '<cmd>Grapple select index=2<cr>',    desc = 'which_key_ignore' },
            { '<leader>3', '<cmd>Grapple select index=3<cr>',    desc = 'which_key_ignore' },
            { '<leader>4', '<cmd>Grapple select index=4<cr>',    desc = 'which_key_ignore' },
            { '<leader>5', '<cmd>Grapple select index=5<cr>',    desc = 'which_key_ignore' },
            { '<leader>6', '<cmd>Grapple select index=6<cr>',    desc = 'which_key_ignore' },
            { '<leader>7', '<cmd>Grapple select index=7<cr>',    desc = 'which_key_ignore' },
            { '<leader>8', '<cmd>Grapple select index=8<cr>',    desc = 'which_key_ignore' },
            { '<leader>9', '<cmd>Grapple select index=9<cr>',    desc = 'which_key_ignore' },
        },
    },
}
