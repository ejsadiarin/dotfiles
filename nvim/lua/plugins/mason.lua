-- Install and Configure LSP servers via 'mason-lspconfig'

return {

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {

        -- Bash
        'bashls', -- lsp
        'shellcheck', -- lint
        'shfmt', -- formatter

        -- Docker
        'dockerls', -- lsp
        'docker_compose_language_service', -- lsp for compose
        'hadolint', -- linter

        -- Ansible
        'ansiblels',
        'ansible-lint',

        -- Python
        'pyright', -- lsp
        'isort', -- sorter
        'black', -- python formatter
        'pylint', -- linter
        'debugpy', -- debugger

        -- HTML, CSS, JS, misc.
        'tsserver', -- lsp
        'html', -- lsp
        'cssls', -- lsp
        'eslint_d', -- linter daemon
        'prettierd', -- formatter daemon
        'prettier', -- formatter
        'js-debug-adapter', -- debugger

        -- C
        'clangd',

        -- C#
        'omnisharp', -- lsp
        'netcoredbg', -- debugger
      },
    },
  },

  -- This is where to configure LSP servers
  {
    'williamboman/mason-lspconfig.nvim',
    opts = {
      handlers = {
        -- See :help mason-lspconfig-dynamic-server-setup
        function(server_name) -- default handler
          -- See :help lspconfig-setup
          --
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
        --  or
        --  ['tsserver'] = function() end,

        -- NOTE: Custom language-specific configurations here
        ['dockerls'] = function()
          require('lspconfig').dockerls.setup {}
        end,
        ['docker_compose_language_service'] = function()
          require('lspconfig').docker_compose_language_service.setup {}
        end,
        ['pyright'] = function() end,
        ['clangd'] = function() end,
        ['bashls'] = function() end,
        ['tsserver'] = function() end,
        ['marksman'] = function()
          require('lspconfig').marksman.setup {}
        end,
        ['omnisharp'] = function()
          require('lspconfig').omnisharp.setup {}
        end,
      },
    },
  },
}
