local Util = require("lazyvim.util")

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    priority = 1000,
    opts = {
      window = {
        position = "current", -- values: 'left' | 'right' | 'top' | 'bottom' | 'float' | 'current' - like netrw
        -- width = 40,
      },
      filesystem = {
        hijack_netrw_behavior = "open_current", -- like netrw but on steriods
        -- [ if want file tree do ]: window.position = "left" or "right"
        -- hijack_netrw_behavior = "open_default", -- defaults to what window.position is
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          -- hide_hidden = false, -- for Windows (use Linux bro)
        },
      },
    },
    keys = function()
      return {
        {
          "<leader>e",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = Util.root() })
          end,
          desc = "Explorer NeoTree (root dir)",
        },
        {
          "<leader>E",
          function()
            require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
        { "<leader>fe", false },
      }
    end,
  },
}
