return {
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
  -- {
  --   "mrded/nvim-lsp-notify",
  --   requires = { "rcarriga/nvim-notify" },
  --   config = function()
  --     require("lsp-notify").setup({})
  --   end,
  -- },
}
