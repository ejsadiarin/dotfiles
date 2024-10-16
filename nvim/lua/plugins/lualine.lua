-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

local function get_schema()
    local schema = require('yaml-companion').get_buf_schema(0)
    if schema.result[1].name == 'none' then
        return ''
    end
    return schema.result[1].name
end

return {
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        -- event = 'VeryLazy',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        opts = {
            options = {
                theme = 'auto', -- 'auto', 'catppuccin', 'tokyonight', 'gruvbox'
                globalstatus = true,
                icons_enabled = true,
                disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'starter' } },
                section_separators = { left = '', right = '' },
                -- section_separators = { left = '', right = '' },
                -- component_separators = { left = "", right = " 󰇙 " },
                component_separators = { left = '', right = '' },
            },
            sections = {
                lualine_a = {
                    {
                        function()
                            if package.loaded['grapple'] and require('grapple').exists() then
                                return '󰛢 ' .. require('grapple').name_or_index()
                            end
                            return '󰛢 N'
                        end,
                        -- cond = function()
                        --   return package.loaded['grapple'] and require('grapple').exists()
                        -- end,
                    },

                    -- {
                    --   'mode',
                    --   -- {'branch', icon = ''} / {'branch', icon = {'', color={fg='green'}}}
                    --
                    --   -- icon position can also be set to the right side from table. Example:
                    --   -- {'branch', icon = {'', align='right', color={fg='green'}}}
                    --   icon = nil,
                    -- },
                },
                lualine_b = {
                    {
                        'branch',
                        icon = { '', align = 'left', color = { fg = '#a6e3a1' } },
                        padding = { left = 1, right = 1 },
                    },
                },

                lualine_c = {
                    -- LazyVim.lualine.root_dir(),
                    { 'filetype', icon_only = true, separator = '', padding = { left = 1, right = 0 } },
                    {
                        'filename',
                        path = 4,
                        padding = { left = 1, right = 1 },
                        shorting_target = 20, -- Shortens path to leave 40 spaces in the window
                        -- for other components. (terrible name, any suggestions?)
                        symbols = {
                            modified = '[+]', -- Text to show when the file is modified.
                            readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
                            unnamed = '[No Name]', -- Text to show for unnamed buffers.
                            newfile = '[New]', -- Text to show for newly created file before first write
                        },
                        -- color = { fg = '#f9cc6c' },
                        color = { fg = '#f38ba8' },
                    },
                    -- { LazyVim.lualine.pretty_path() },
                    {
                        'diagnostics',
                        symbols = {
                            error = ' ',
                            warn = ' ',
                            info = ' ',
                            hint = ' ',
                        },
                        padding = { left = 1, right = 1 },
                    },
                },

                lualine_x = {
                    -- stylua: ignore
                    -- {
                    --   function() return require("noice").api.status.command.get() end,
                    --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() e-- Additional schemas available in Telescope picker
                    --   color = LazyVim.ui.fg("Statement"),
                    -- },
                    -- -- stylua: ignore
                    -- {
                    --   function() return require("noice").api.status.mode.get() end,
                    --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
                    --   color = LazyVim.ui.fg("Constant"),
                    -- },
                    -- -- stylua: ignore
                    -- {
                    --   function() return "  " .. require("dap").status() end,
                    --   cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
                    --   color = LazyVim.ui.fg("Debug"),
                    -- },
                    -- {
                    --   require('lazy.status').updates,
                    --   cond = require('lazy.status').has_updates,
                    --   color = LazyVim.ui.fg 'Special',
                    -- },
                    {
                        function() return get_schema() end,
                        padding = { left = 1, right = 1 },
                        cond = function() return require('yaml-companion') ~= nil end, -- optional condition to ensure yaml-companion is loaded
                    },

                    {
                        'diff',
                        colored = true,
                        symbols = {
                            added = ' ', -- added = " ",
                            modified = ' ',
                            removed = ' ',
                        },
                        source = function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if gitsigns then
                                return {
                                    added = gitsigns.added,
                                    modified = gitsigns.changed,
                                    removed = gitsigns.removed,
                                }
                            end
                        end,
                    },
                    { 'filetype', separator = '', padding = { left = 1, right = 1 } },
                    -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 1 } },
                },
                lualine_y = {
                    { 'location', padding = { left = 0, right = 1 } },
                },
                lualine_z = {
                    { 'progress', padding = { left = 0, right = 1 } },
                },
            },
        },
    },
}
