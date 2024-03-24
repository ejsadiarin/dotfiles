return {
  {
    "j-hui/fidget.nvim",
    lazy = false,
    opts = {
      notification = {
        override_vim_notify = true,
        -- configs = { default = require("fidget.option.notification").default_config },
        -- Conditionally redirect notifications to another backend
        redirect = function(msg, level, opts)
          if opts and opts.on_open then
            return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
          end
        end,
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
      },
      logger = {
        level = vim.log.levels.WARN, -- Minimum logging level
        float_precision = 0.01, -- Limit the number of decimals displayed for floats
        -- Where Fidget writes its logs to
        path = string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
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
    -- end,
  },
  -- {
  --   "mrded/nvim-lsp-notify",
  --   requires = { "rcarriga/nvim-notify" },
  --   config = function()
  --     require("lsp-notify").setup({})
  --   end,
  -- },
}
