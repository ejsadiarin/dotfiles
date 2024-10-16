-- see :h bufferline-configuration for specific opts

return {
    {
        'akinsho/bufferline.nvim',
        event = 'VeryLazy',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
        keys = {
            { '<leader>bd', '<cmd>:bd<cr>',                   desc = 'Buffer [D]elete' },
            { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete Other Buffers' },
            { '<leader>br', '<Cmd>BufferLineCloseRight<CR>',  desc = 'Delete Buffers to the Right' },
            { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>',   desc = 'Delete Buffers to the Left' },
            { '<S-h>',      '<cmd>BufferLineCyclePrev<cr>',   desc = 'Prev Buffer' },
            { '<S-l>',      '<cmd>BufferLineCycleNext<cr>',   desc = 'Next Buffer' },
        },
        opts = {
            options = {
                close_command = 'bdelete! %d', -- can be a string | function, | false see "Mouse actions"
                right_mouse_command = 'bdelete! %d', -- can be a string | function | false, see "Mouse actions"
                left_mouse_command = 'buffer %d', -- can be a string | function, | false see "Mouse actions"
                middle_mouse_command = nil,  -- can be a string | function, | false see "Mouse actions"
                diagnostics = 'nvim_lsp',
                always_show_bufferline = false,

                --- count is an integer representing total count of errors
                --- level is a string "error" | "warning"
                --- diagnostics_dict is a dictionary from error level ("error", "warning" or "info")to number of errors for each level.
                --- this should return a string
                --- Don't get too fancy as this function will be executed a lot
                diagnostics_indicator = function(count, level, diag_dict, context)
                    -- local icon = level:match 'error' and ' ' or ' '
                    local icons = {
                        error = ' ',
                        warning = ' ',
                        hint = ' ',
                        info = ' ',
                    }
                    local ret = (diag_dict.error and icons.error .. diag_dict.error .. ' ' or '') ..
                    (diag_dict.warning and icons.warning .. diag_dict.warning or '')
                    return vim.trim(ret) -- return ' ' .. icon .. count
                end,
                -- diagnostics_indicator = function(_, _, diag)
                --   -- local icons = require('lazyvim.config').icons.diagnostics
                --   local ret = (diag.error and icons.Error .. diag.error .. ' ' or '') .. (diag.warning and icons.Warn .. diag.warning or '')
                --   return vim.trim(ret)
                -- end,

                offsets = {
                    {
                        filetype = 'neo-tree',
                        text = 'Neo-tree',
                        highlight = 'Directory',
                        text_align = 'left',
                    },
                },
            },
        },
        config = function(_, opts)
            require('bufferline').setup(opts)
            -- Fix bufferline when restoring a session
            vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
                callback = function()
                    vim.schedule(function()
                        pcall(nvim_bufferline)
                    end)
                end,
            })
        end,
    },
}
