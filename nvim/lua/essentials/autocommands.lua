-- ################################
-- #    AUTOCOMMANDS (AUTOCMD)    #
-- ################################
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    pattern = '*',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- save cursor position
vim.api.nvim_create_autocmd({ 'VimEnter', 'CursorMoved' }, {
    desc = 'Retain cursor at end after yanking',
    group = vim.api.nvim_create_augroup('save-cursor-position', { clear = true }),
    callback = function()
        cursor_pos = vim.fn.getpos '.'
    end,
})

-- Retain cursor position after yank (cursor pos at end, not at start)
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Retain cursor at end after yanking',
    group = vim.api.nvim_create_augroup('retain-cursor-yank', { clear = true }),
    pattern = '*',
    callback = function()
        if vim.v.event.operator == 'y' then
            vim.fn.setpos('.', cursor_pos)
        end
    end,
})

-- -- Remove padding around neovim instance (OSC 11 and OSC 111 keeps terminal background color in sync with Neovim's bg color)
-- -- see: https://www.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
-- -- also see: `mini.misc` module from 'mini.nvim' setup_termbg_sync() (ref: https://github.com/echasnovski/mini.nvim/blob/74e6b722c91113bc70d4bf67249ed8de0642b20e/doc/mini-misc.txt#L171)
-- -- NOTE: (1) Make sure to have this executed before you load color scheme. Otherwise there will be no event for it to sync. Alternatively, add an explicit call to the first callback function and it should work as is.
-- -- (2) It will not sync if you manually set Normal highlight group. It must be followed by the ColorScheme event.
-- vim.api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
--   callback = function()
--     local normal = vim.api.nvim_get_hl(0, { name = 'Normal' })
--     if not normal.bg then
--       return
--     end
--     io.write(string.format('\027]11;#%06x\027\\', normal.bg))
--   end,
-- })
-- vim.api.nvim_create_autocmd('UILeave', {
--   callback = function()
--     io.write '\027]111\027\\'
--   end,
-- })

-- add 'q' keymap on command mode to close quickfix window and 'help' filetypes
vim.api.nvim_create_autocmd('filetype', {
    pattern = {
        'qf',
        'help',
        'PlenaryTestPopup',
        'grug-far',
        'lspinfo',
        'notify',
        'spectre_panel',
        'startuptime',
        'tsplayground',
        'neotest-output',
        'checkhealth',
        'neotest-summary',
        'neotest-output-panel',
        'dbout',
        'gitsigns.blame',
    },
    callback = function()
        vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = 0, nowait = true, silent = true })
    end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd('BufReadPost', {
    group = vim.api.nvim_create_augroup('last-loc', { clear = true }),
    callback = function(event)
        local exclude = { 'gitcommit' }
        local buf = event.buf
        if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
            return
        end
        vim.b[buf].lazyvim_last_loc = true
        local mark = vim.api.nvim_buf_get_mark(buf, '"')
        local lcount = vim.api.nvim_buf_line_count(buf)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = vim.api.nvim_create_augroup('json-conceallevel', { clear = true }),
    pattern = { 'json', 'jsonc', 'json5' },
    callback = function()
        vim.opt_local.conceallevel = 0
    end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
    group = vim.api.nvim_create_augroup('resize-splits', { clear = true }),
    callback = function()
        local current_tab = vim.fn.tabpagenr()
        vim.cmd 'tabdo wincmd ='
        vim.cmd('tabnext ' .. current_tab)
    end,
})

-- auto insert mode on terminal mode when 'term://' opened
vim.api.nvim_create_autocmd({ 'TermOpen', 'BufEnter' }, {
    group = vim.api.nvim_create_augroup('auto-insert-on-term-mode', { clear = true }),
    pattern = { '*' },
    callback = function()
        if vim.opt.buftype:get() == 'terminal' then
            vim.cmd ':startinsert'
        end
    end,
})

-- TODO: moving qflist on cursor move
-- vim.api.nvim_create_autocmd('CursorMoved', {
--   pattern = 'qf',
--   callback = function()
--     vim.cmd [[ copen ]]
--   end,
-- })

-- -- set conceallevel = 0 for markdown files
-- vim.api.nvim_create_autocmd('FileType', {
--   group = vim.api.nvim_create_augroup('markdown-conceallevel', { clear = true }),
--   pattern = 'markdown',
--   callback = function()
--     vim.opt_local.conceallevel = 0 -- so that everything is visible in markdown files
--   end,
-- })

-- :Telescope yaml_schema from 'yaml-companion'
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('telescope-yaml-schema', { clear = true }),
    pattern = { 'yaml', 'yml' },
    callback = function()
        vim.keymap.set('n', '<leader>cs', '<cmd>Telescope yaml_schema<cr>', { desc = 'Change yaml [s]chema' })
    end,
})

-- disable treesitter on large files
local aug = vim.api.nvim_create_augroup('buf_large', { clear = true })
vim.api.nvim_create_autocmd({ 'BufReadPre' }, {
    callback = function()
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
        if ok and stats and (stats.size > 1000000) then
            vim.cmd 'syntax off'
            vim.b.large_buf = true
            vim.opt_local.foldmethod = 'manual'
            vim.opt_local.spell = false
        else
            vim.b.large_buf = false
        end
    end,
    group = aug,
    pattern = '*',
})

-- do :w on :W (remaps)
vim.api.nvim_create_user_command('W', 'w', {})
