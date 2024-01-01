return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>h"] = { name = "+harpoon" },
        ["<leader>v"] = { name = "+visual-multi" },
        ["<leader>r"] = { name = "+hacks" },
      },
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
    "nvim-neo-tree/neo-tree.nvim",
    priority = 1000,
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
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
    opts = {
      enable_close_on_slash = false,
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
    -- opts = {
    --   window = {
    --     winblend = 100,
    --     relative = "editor",
    --   },
    -- },
    config = function()
      require("fidget").setup({
        window = {
          blend = 0,
          relative = "editor",
        },
      })
    end,
    tag = "legacy",
  },

  -- {
  -- 	"rcarriga/nvim-notify",
  -- 	opts = {
  -- 		background_colour = "#1d2021",
  -- 	},
  -- },

  {
    "davidosomething/format-ts-errors.nvim",
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
    "someone-stole-my-name/yaml-companion.nvim",
    ft = { "yaml" },
    opts = {
      builtin_matchers = {
        kubernetes = { enabled = true },
      },
    },
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function(_, opts)
      local cfg = require("yaml-companion").setup(opts)
      require("lspconfig")["yamlls"].setup(cfg)
      require("telescope").load_extension("yaml_schema")
    end,
  },

  {
    "ahmedkhalf/project.nvim",
    opts = {
      manual_mode = false,
    },
    event = "VeryLazy",
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("lazyvim.util").on_load("telescope.nvim", function()
        require("telescope").load_extension("projects")
      end)
    end,
    keys = {
      {
        "<leader>fp",
        -- function()
        --   vim.cmd([[Telescope projects]])
        -- end,
        -- or:
        vim.schedule_wrap(function()
          require("telescope").extensions.projects.projects({})
        end),
        desc = "Projects",
      },
    },
  },

  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
  },

  {
    "stevearc/oil.nvim",
    opts = {
      default_file_explorer = false,
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
    },
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
