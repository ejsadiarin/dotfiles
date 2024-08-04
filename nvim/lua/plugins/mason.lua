return {
  {
    'williamboman/mason.nvim',
    config = true,
    opts = {
      ui = {
        border = 'rounded',
      },
    },
  },

  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      handlers = {
        -- See :help mason-lspconfig-dynamic-server-setup
        function(server_name) -- default handler
          -- See :help lspconfig-setup
          require('lspconfig')[server_name].setup {}
        end,

        -- NOTE: This is the LSP configuration handlers
        -- Enable the following language servers.
        -- Feel free to add/remove any LSPs that you want here. They will automatically be installed.
        --
        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --
        --  For example: (to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/)
        --   lua_ls = {
        --     cmd = {...},
        --     filetypes = { ...},
        --     capabilities = {},
        --     settings = {...}
        --
        --	...etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --  -- Some languages (like typescript) have entire language plugins that can be useful:
        --  --    https://github.com/pmizio/typescript-tools.nvim
        --  --
        --  -- But for many setups, the LSP (`tsserver`) will work just fine
        --  tsserver = {},
        --

        ['lua_ls'] = function()
          -- if you install the language server for lua it will load the config from lua/plugins/lsp/lua_ls.lua
          require 'plugins.lsp.lua_ls'
        end,
        ['gopls'] = function()
          require 'plugins.lsp.gopls'
        end,
        ['pyright'] = function() end,
        ['clangd'] = function() end,
        ['bashls'] = function() end,
        ['tsserver'] = function() end,
      },
    },
  },

  -- Mason Auto-Installer (with Auto-update, pin versions, etc.)
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
        -- Bash
        'bashls',
        'shellcheck', -- for lint
        -- Lua
        'lua_ls',
        'stylua', -- Used to format Lua code
        -- Python
        'pyright', -- python formatter
        'isort', -- python formatter
        'black', -- python formatter
        'pylint',
        -- HTML, CSS, JS, misc.
        'tsserver',
        'eslint_d',
        'prettierd',
        'prettier',
        -- C
        'clangd',
      },
    },
  },
}
