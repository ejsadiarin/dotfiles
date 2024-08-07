-- local lspconfig = require 'lspconfig'

return {
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      handlers = {
        ['gopls'] = function()
          require 'plugins.lsp.gopls'
        end,
        -- ['go'] = function()
        --   require('lspconfig').html.setup(vim.tbl_deep_extend('force', lsp_options, {
        --     filetypes = { 'html', 'htmldjango' },
        --   }))
        -- end,
      },
    },
  },
  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        -- Go
        'gopls',
        'goimports', -- for formatting imports
        'gofumpt', -- gofmt
        'gomodifytags', -- add tags to struct fields
        'impl', -- generate interface methods
        'delve', -- debugger
        -- { 'golangci-lint', version = 'v1.47.0' },
      },
    },
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'go',
        'gomod',
        'gowork',
        'gosum',
      },
    },
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    opts = {
      -- automatic_installation = true,
      ensure_installed = {
        'delve',
      },
    },
  },
  {
    'leoluz/nvim-dap-go',
    ft = 'go',
    opts = {
      -- Install golang specific config
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    },
  },
}
