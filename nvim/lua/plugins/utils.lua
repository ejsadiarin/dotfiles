local Util = require("lazyvim.util")

return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        -- ["<leader>h"] = { name = "+harpoon" },
        ["<leader>v"] = { name = "+visual-multi" },
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    },
  },

  {
    "smjonas/inc-rename.nvim",
    config = function()
      require("inc_rename").setup()
    end,
  },

  {
    "mg979/vim-visual-multi",
  },

  -- {
  --   "folke/noice.nvim",
  --   opts = function(_, opts)
  --     table.insert(opts.routes, {
  --       filter = {
  --         event = "notify",
  --         find = "No information available",
  --       },
  --       opts = { skip = true },
  --     })
  --   end,
  --   presets = { inc_rename = true },
  --   cmdline = { enabled = false },
  --   messages = { enabled = false },
  -- },
  {
    "folke/noice.nvim",
    opts = {
      cmdline = {
        enabled = false,
      },
      messages = {
        enabled = false,
      },
      presets = {
        inc_rename = false,
      },
    },
    config = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
    end,
  },
  -- extend noice functionality
  --  {
  -- 	"folke/noice.nvim",
  -- 	opts = function(_, opts)
  -- 		table.insert(opts.routes, {
  -- 			filter = {
  -- 				event = "notify",
  -- 				find = "No information available",
  -- 			},
  -- 			opts = { skip = true },
  -- 		})
  -- 	end,
  -- 	presets = { inc_rename = true },
  -- },

  {
    "norcalli/nvim-colorizer.lua",
    opts = {
      filetypes = {
        "html",
        "css",
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "lua",
      },
      user_default_options = {
        mode = "background",
        tailwind = false, -- Enable tailwind colors
      },
    },
  },
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    opts = {
      color_square_width = 2,
    },
  },
  -- highlight css colors
  -- {
  --   "brenoprata10/nvim-highlight-colors",
  --   opts = {
  --     ft = { "css" },
  --     config = true,
  --     lazy = true,
  --   },
  -- },
  {
    "windwp/nvim-autopairs",
    event = "VeryLazy",
    -- event = "InsertEnter",
    opts = {
      disable_filetype = { "TelescopePrompt", "vim" },
    },
  },

  {
    "echasnovski/mini.surround",
    opts = {
      mappings = {
        add = "sa",
        delete = "sd",
        find = "sf",
        find_left = "sF",
        highlight = "sh",
        replace = "sr",
        update_n_lines = "sn",
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    lazy = false,
    opts = {
      enable_close_on_slash = false,
      autotag = {
        enable = true,
      },
    },
  },
  {
    "Issafalcon/lsp-overloads.nvim",
    -- next_signature = "<C-j>"
    -- previous_signature = "<C-k>"
    -- next_parameter = "<C-l>"
    -- previous_parameter = "<C-h>"
    -- close_signature = "<A-s>"
  },

  {
    "j-hui/fidget.nvim",
    lazy = false,
    opts = {
      notification = {
        override_vim_notify = true,
        -- configs = { default = require("fidget.option.notification").default_config },
        -- Conditionally redirect notifications to another backend
        -- redirect = function(msg, level, opts)
        --   if opts and opts.on_open then
        --     return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
        --   end
        -- end,
        view = {
          stack_upwards = true,
          icon_separator = " ",
          group_separator = "---",
          group_separator_hl = "Comment",
        },
        window = {
          winblend = 0,
          align = "bottom",
          relative = "editor",
        },
        -- logger = {
        --   level = vim.log.levels.WARN, -- Minimum logging level
        --   float_precision = 0.01, -- Limit the number of decimals displayed for floats
        --   -- Where Fidget writes its logs to
        --   -- path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
        -- },
      },
    },
    keys = {
      {
        "<leader>sf",
        function()
          require("telescope").extensions.notify.notify(require("notify").history())
        end,
        desc = "Open notification history",
      },
    },
  },

  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.25)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
      background_colour = "#000000",
      stages = "static",
      render = "compact",
    },
    -- config = function()
    --   vim.notify = require("notify")
    -- end,
  },

  {
    "barrett-ruth/live-server.nvim",
    build = "npm i -g live-server",
    config = true,
    opts = {
      args = { "--host=localhost", "--port=8080" },
    },
    -- :h live-server
    -- :LiveServerStart
    -- :LiveServerStop
  },

  {
    "AndrewRadev/inline_edit.vim",
    -- Execute :InlineEdit within the script tag.
    -- A proxy buffer is opened with only the javascript.
    -- Saving the proxy buffer updates the original one.
    -- You can reindent, lint, slice and dice as much as you like.
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },
  {
    "sindrets/diffview.nvim",
    opts = {
      default = {
        layout = "diff3_mixed",
      },
    },
    keys = {
      { "<leader>gd", "<CMD>DiffviewOpen<CR>", desc = "Git Diff View" },
      { "<leader>gf", "<CMD>DiffviewFileHistory %<CR>", desc = "Git Diff File History" },
      { "<leader>gx", "<CMD>DiffviewClose<CR>", desc = "Git Diff Close" },
    },
    config = function()
      require("diffview").setup({
        keymaps = {
          view = {
            ["<tab>"] = false,
            {
              "n",
              "<s-tab>",
              require("diffview.actions").select_next_entry,
              { desc = "Open the diff for the next file" },
            },
            { "n", "<leader>e", require("diffview.actions").toggle_files, { desc = "Toggle file panel" } },
          },
          file_panel = {
            ["<tab>"] = false,
            {
              "n",
              "<s-tab>",
              require("diffview.actions").select_next_entry,
              { desc = "Open the diff for the next file" },
            },
            { "n", "<leader>e", require("diffview.actions").toggle_files, { desc = "Toggle file panel" } },
          },
          file_history_panel = {
            ["<tab>"] = false,
            {
              "n",
              "<s-tab>",
              require("diffview.actions").select_next_entry,
              { desc = "Open the diff for the next file" },
            },
            { "n", "<leader>e", require("diffview.actions").toggle_files, { desc = "Toggle file panel" } },
          },
        },
      })
    end,
  },
}
-- icons = {
--   misc = {
--     dots = "󰇘",
--   },
--   dap = {
--     Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
--     Breakpoint          = " ",
--     BreakpointCondition = " ",
--     BreakpointRejected  = { " ", "DiagnosticError" },
--     LogPoint            = ".>",
--   },
--   diagnostics = {
--     Error = " ",
--     Warn  = " ",
--     Hint  = " ",
--     Info  = " ",
--   },
--   git = {
--     added    = " ",
--     modified = " ",
--     removed  = " ",
--   },
--   kinds = {
--     Array         = " ",
--     Boolean       = "󰨙 ",
--     Class         = " ",
--     Codeium       = "󰘦 ",
--     Color         = " ",
--     Control       = " ",
--     Collapsed     = " ",
--     Constant      = "󰏿 ",
--     Constructor   = " ",
--     Copilot       = " ",
--     Enum          = " ",
--     EnumMember    = " ",
--     Event         = " ",
--     Field         = " ",
--     File          = " ",
--     Folder        = " ",
--     Function      = "󰊕 ",
--     Interface     = " ",
--     Key           = " ",
--     Keyword       = " ",
--     Method        = "󰊕 ",
--     Module        = " ",
--     Namespace     = "󰦮 ",
--     Null          = " ",
--     Number        = "󰎠 ",
--     Object        = " ",
--     Operator      = " ",
--     Package       = " ",
--     Property      = " ",
--     Reference     = " ",
--     Snippet       = " ",
--     String        = " ",
--     Struct        = "󰆼 ",
--     TabNine       = "󰏚 ",
--     Text          = " ",
--     TypeParameter = " ",
--     Unit          = " ",
--     Value         = " ",
--     Variable      = "󰀫 ",
--   },
