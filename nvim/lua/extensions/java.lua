-- Configuration exists in `ftplugin/java.lua`

return {
  {
    'mfussenegger/nvim-jdtls',
    dependencies = {
      {
        'mfussenegger/nvim-dap',
      },
    },
    config = function()
      -- setup DAP (debugger) for java
      local dap = require 'dap'
      dap.configurations.java = {
        {
          type = 'java-debug',
          request = 'attach',
          name = 'Debug (Attach) - Remote',
          -- hostName = '127.0.0.1',
          -- port = 5005,
        },
      }
    end,
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      -- make sure mason installs the server
      servers = {
        jdtls = {},
      },
      setup = {
        jdtls = function()
          return true -- avoid duplicate servers
        end,
      },
    },
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        -- Java
        'jdtls',
        'java-debug-adapter',
        'java-test',
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'java' } },
  },

  {
    'mfussenegger/nvim-dap',
    optional = true,
    dependencies = {
      {
        'williamboman/mason.nvim',
        opts = { ensure_installed = { 'java-debug-adapter', 'java-test' } },
      },
    },
  },
}
