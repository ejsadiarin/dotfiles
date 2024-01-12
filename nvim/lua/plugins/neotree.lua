local Util = require("lazyvim.util")

return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      window = {
        -- position = "current", -- values: 'left' | 'right' | 'top' | 'bottom' | 'float' | 'current' - like netrw
        position = "top",
        -- width = 10,
        height = 40,
      },
      filesystem = {
        -- hijack_netrw_behavior = "open_current", -- like netrw but on steriods
        -- [ if want file tree do ]: window.position = "left" or "right"
        hijack_netrw_behavior = "open_default", -- defaults to what window.position is
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          -- hide_hidden = false, -- for Windows (use Linux bro)
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
      },
      event_handlers = {
        -- auto-close neo-tree on file open
        {
          event = "file_opened",
          handler = function(file_path)
            -- auto close
            -- vimc.cmd("Neotree close")
            -- OR
            require("neo-tree.command").execute({ action = "close" })
          end,
        },
      },
    },
    keys = function()
      return {
        {
          "<leader>e",
          function()
            require("neo-tree.command").execute({
              toggle = true,
              -- dir = Util.root(),
              dir = vim.loop.cwd(),
              -- reveal_file = reveal_file,
              -- reveal_force_cwd = true,
            })
          end,
          desc = "Explorer NeoTree (cwd)",
        },
        {
          "<leader>E",
          function()
            require("neo-tree.command").execute({
              toggle = true,
              dir = Util.root(),
              -- dir = vim.loop.cwd(),
            })
          end,
          desc = "Explorer NeoTree (root/dynamic)",
        },
        { "<leader>fe", false },
      }
    end,
  },
}
