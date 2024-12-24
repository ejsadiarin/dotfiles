return {
    {
        'neovim/nvim-lspconfig',
        opts = function(_, opts)
            local servers = { 'basedpyright', 'ruff', 'ruff_lsp' }
            for _, server in ipairs(servers) do
                opts.servers[server] = opts.servers[server] or {}
                -- opts.servers[server].enabled = server == lsp or server == ruff
            end
        end,
    },

    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
            ensure_installed = {
                -- Python
                'basedpyright',                -- lsp
                'isort',                       -- sorter
                'black',                       -- python formatter
                'pylint',                      -- linter
                'debugpy',                     -- debugger
            },
        },
    },

    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            ensure_installed = {
                'python',
            },
        },
    },
}
