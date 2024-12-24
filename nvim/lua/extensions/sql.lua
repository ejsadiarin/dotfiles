return {

    {
        'tpope/vim-dadbod',
        cmd = 'DB',
    },

    {
        'kristijanhusak/vim-dadbod-completion',
        dependencies = 'vim-dadbod',
        ft = { 'sql', 'mysql', 'plsql' },
        init = function()
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'sql', 'mysql', 'plsql' },
                callback = function()
                    local cmp = require 'cmp'

                    -- global sources
                    ---@param source cmp.SourceConfig
                    local sources = vim.tbl_map(function(source)
                        return { name = source.name }
                    end, cmp.get_config().sources)

                    -- add vim-dadbod-completion source
                    table.insert(sources, { name = 'vim-dadbod-completion' })

                    -- update sources for the current buffer
                    cmp.setup.buffer { sources = sources }
                end,
            })
        end,
    },

    {
        'kristijanhusak/vim-dadbod-ui',
        ft = { 'sql', 'mysql', 'plsql' },
        dependencies = {
            { 'tpope/vim-dadbod',                     lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        keys = {
            { '<leader>ccu', '<cmd>DBUIToggle<cr>', desc = 'SQL: Open [u]I' },
        },
        init = function()
            -- Your DBUI configuration
            -- vim.g.db_ui_use_nerd_fonts = 1

            local data_path = vim.fn.stdpath 'data' -- this is in ~/.local/share/nvim/

            vim.g.db_ui_auto_execute_table_helpers = 1
            vim.g.db_ui_save_location = data_path .. '/dadbod_ui'
            vim.g.db_ui_show_database_icon = true
            vim.g.db_ui_tmp_query_location = data_path .. '/dadbod_ui/tmp'
            vim.g.db_ui_use_nerd_fonts = true
            vim.g.db_ui_use_nvim_notify = true

            -- NOTE: The default behavior of auto-execution of queries on save is disabled
            -- this is useful when you have a big query that you don't want to run every time
            -- you save the file running those queries can crash neovim to run use the
            -- default keymap: <leader>S
            vim.g.db_ui_execute_on_save = false
        end,
    },

    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            ensure_installed = {
                'sql',
            },
        },
    },

    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        opts = {
            ensure_installed = {
                'sqlls',             -- lsp
                'sqlfluff',          -- linter
            }
        }
    }
    -- {
    --   'stevearc/conform.nvim',
    --   optional = true,
    --   opts = function(_, opts)
    --     opts.formatters.sqlfluff = {
    --       args = { 'format', '--dialect=ansi', '-' },
    --     }
    --     for _, ft in ipairs { 'sql', 'mysql', 'plsql' } do
    --       opts.formatters_by_ft[ft] = opts.formatters_by_ft[ft] or {}
    --       table.insert(opts.formatters_by_ft[ft], 'sqlfluff')
    --     end
    --   end,
    -- },
}
