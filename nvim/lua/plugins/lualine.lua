-- local function lsp_progress()
--   local messages = vim.lsp.util.get_progress_messages()
--   if #messages == 0 then
--     return
--   end
--   local status = {}
--   for _, msg in pairs(messages) do
--     table.insert(status, (msg.percentage or 0) .. "%% " .. (msg.title or ""))
--   end
--   local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
--   local ms = vim.loop.hrtime() / 1000000
--   local frame = math.floor(ms / 120) % #spinners
--   return table.concat(status, " | ") .. " " .. spinners[frame + 1]
-- end

return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      -- PERF: we don't need this lualine require madness 🤷
      local lualine_require = require("lualine_require")
      lualine_require.require = require

      local icons = require("lazyvim.config").icons

      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          icons_enabled = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          section_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          -- component_separators = { left = "", right = " 󰇙 " },
          component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = {
            {
              "mode",
              -- {'branch', icon = ''} / {'branch', icon = {'', color={fg='green'}}}

              -- icon position can also be set to the right side from table. Example:
              -- {'branch', icon = {'', align='right', color={fg='green'}}}
              icon = nil,
            },
          },
          lualine_b = {},

          lualine_c = {
            -- LazyVim.lualine.root_dir(),
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            {
              "filename",
              path = 4,
              padding = { left = 1, right = 1 },
              shorting_target = 20, -- Shortens path to leave 40 spaces in the window
              -- for other components. (terrible name, any suggestions?)
              symbols = {
                modified = "[+]", -- Text to show when the file is modified.
                readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "[No Name]", -- Text to show for unnamed buffers.
                newfile = "[New]", -- Text to show for newly created file before first write
              },
              color = { fg = "#f38ba8" },
            },
            -- { LazyVim.lualine.pretty_path() },
            {
              "branch",
              icon = { "", align = "left", color = { fg = "#a6e3a1" } },
              padding = { left = 1, right = 1 },
            },
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
              padding = { left = 1, right = 1 },
            },
          },

          lualine_x = {
          -- stylua: ignore
          {
            function() return require("noice").api.status.command.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            color = LazyVim.ui.fg("Statement"),
          },
          -- stylua: ignore
          {
            function() return require("noice").api.status.mode.get() end,
            cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            color = LazyVim.ui.fg("Constant"),
          },
          -- stylua: ignore
          {
            function() return "  " .. require("dap").status() end,
            cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
            color = LazyVim.ui.fg("Debug"),
          },
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = LazyVim.ui.fg("Special"),
            },
            {
              "diff",
              colored = true,
              symbols = {
                -- added = " ",
                added = icons.git.added,
                modified = " ",
                removed = " ",
                -- modified = icons.git.modified,
                -- removed = icons.git.removed,
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
            { "filetype", separator = "", padding = { left = 1, right = 1 } },
            -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 1 } },
          },
          lualine_y = {
            { "location", padding = { left = 0, right = 1 } },
          },
          lualine_z = {
            { "progress", padding = { left = 0, right = 1 } },
          },
        },
        extensions = { "neo-tree", "lazy" },
      }
    end,
  },
}

-- from LazyVim:
-- {
--   "nvim-lualine/lualine.nvim",
--   event = "VeryLazy",
--   init = function()
--     vim.g.lualine_laststatus = vim.o.laststatus
--     if vim.fn.argc(-1) > 0 then
--       -- set an empty statusline till lualine loads
--       vim.o.statusline = " "
--     else
--       -- hide the statusline on the starter page
--       vim.o.laststatus = 0
--     end
--   end,
--   opts = function()
--     -- PERF: we don't need this lualine require madness 🤷
--     local lualine_require = require("lualine_require")
--     lualine_require.require = require
--
--     local icons = require("lazyvim.config").icons
--
--     vim.o.laststatus = vim.g.lualine_laststatus
--
--     return {
--       options = {
--         theme = "auto",
--         globalstatus = true,
--         disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
--       },
--       sections = {
--         lualine_a = { "mode" },
--         lualine_b = { "branch" },
--
--         lualine_c = {
--           Util.lualine.root_dir(),
--           {
--             "diagnostics",
--             symbols = {
--               error = icons.diagnostics.Error,
--               warn = icons.diagnostics.Warn,
--               info = icons.diagnostics.Info,
--               hint = icons.diagnostics.Hint,
--             },
--           },
--           { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
--           { Util.lualine.pretty_path() },
--         },
--         lualine_x = {
--           -- stylua: ignore
--           {
--             function() return require("noice").api.status.command.get() end,
--             cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
--             color = Util.ui.fg("Statement"),
--           },
--           -- stylua: ignore
--           {
--             function() return require("noice").api.status.mode.get() end,
--             cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
--             color = Util.ui.fg("Constant"),
--           },
--           -- stylua: ignore
--           {
--             function() return "  " .. require("dap").status() end,
--             cond = function () return package.loaded["dap"] and require("dap").status() ~= "" end,
--             color = Util.ui.fg("Debug"),
--           },
--           {
--             require("lazy.status").updates,
--             cond = require("lazy.status").has_updates,
--             color = Util.ui.fg("Special"),
--           },
--           {
--             "diff",
--             symbols = {
--               added = icons.git.added,
--               modified = icons.git.modified,
--               removed = icons.git.removed,
--             },
--             source = function()
--               local gitsigns = vim.b.gitsigns_status_dict
--               if gitsigns then
--                 return {
--                   added = gitsigns.added,
--                   modified = gitsigns.changed,
--                   removed = gitsigns.removed,
--                 }
--               end
--             end,
--           },
--         },
--         lualine_y = {
--           { "progress", separator = " ", padding = { left = 1, right = 0 } },
--           { "location", padding = { left = 0, right = 1 } },
--         },
--         lualine_z = {
--           function()
--             return " " .. os.date("%R")
--           end,
--         },
--       },
--       extensions = { "neo-tree", "lazy" },
--     }
--   end,
-- }
