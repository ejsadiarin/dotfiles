return {
  -- Beautiful Markdown Renderer (like conceallevel = 3 but on steroids)
  {
    'OXY2DEV/markview.nvim',
    ft = 'markdown',

    dependencies = {
      -- You may not need this if you don't lazy load
      -- Or if the parsers are in your $RUNTIMEPATH
      'nvim-treesitter/nvim-treesitter',

      'nvim-tree/nvim-web-devicons',
    },
    -- opts = {
    --   buf_ignore = { 'nofile' },
    --   modes = { 'n', 'no' },
    --
    --   options = {
    --     on_enable = {},
    --     on_disable = {},
    --   },
    --
    --   block_quotes = {},
    --   checkboxes = {},
    --   code_blocks = {},
    --   headings = {},
    --   horizontal_rules = {},
    --   inline_codes = {},
    --   links = {},
    --   list_items = {},
    --   tables = {},
    -- },
    keys = {
      { '<leader>um', '<cmd>Markview<cr>', desc = 'MD: Toggle [m]arkdown View' },
    },
  },
}
