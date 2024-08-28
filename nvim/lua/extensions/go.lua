-- Configures additional things for Go programming language support
-- --> specific lsp config is already configured in plugins/lspconfig.lua

return {

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
        'golangci-lint',
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

  {
    'mfussenegger/nvim-lint',
    opts = {
      lint = {
        linters_by_ft = {
          go = { 'golangci-lint' },
        },
      },
    },
  },

  -- {
  --   'williamboman/mason-lspconfig.nvim',
  --   opts = {
  --     handlers = {
  --       ['gopls'] = function()
  --         require('lspconfig').gopls.setup {
  --           cmd = { 'gopls', 'serve' },
  --           filetypes = { 'go' },
  --           -- capabilities = require('cmp_nvim_lsp').default_capabilities(),
  --           settings = {
  --             gopls = {
  --               gofumpt = true,
  --               codelenses = {
  --                 gc_details = false,
  --                 generate = true,
  --                 regenerate_cgo = true,
  --                 run_govulncheck = true,
  --                 test = true,
  --                 tidy = true,
  --                 upgrade_dependency = true,
  --                 vendor = true,
  --               },
  --               hints = {
  --                 assignVariableTypes = true,
  --                 compositeLiteralFields = true,
  --                 compositeLiteralTypes = true,
  --                 constantValues = true,
  --                 functionTypeParameters = true,
  --                 parameterNames = true,
  --                 rangeVariableTypes = true,
  --               },
  --               analyses = {
  --                 fieldalignment = true,
  --                 nilness = true,
  --                 unusedparams = true,
  --                 unusedwrite = true,
  --                 useany = true,
  --               },
  --               usePlaceholders = true,
  --               completeUnimported = true,
  --               staticcheck = true,
  --               directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
  --               semanticTokens = true,
  --             },
  --           },
  --           on_init = function(client)
  --             if client.name == 'gopls' and not client.server_capabilities.semanticTokensProvider then
  --               local semantic = client.config.capabilities.textDocument.semanticTokens
  --               client.server_capabilities.semanticTokensProvider = {
  --                 full = true,
  --                 legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
  --                 range = true,
  --               }
  --             end
  --           end,
  --         }
  --       end,
  --       -- ['gopls'] = function()
  --       --   require('lspconfig').html.setup(vim.tbl_deep_extend('force', lsp_options, {
  --       --     filetypes = { 'go' },
  --       --   }))
  --       -- end,
  --     },
  --   },
  -- },
  --
  -- {
  --   'neovim/nvim-lspconfig',
  --   opts = {
  --     servers = {
  --       gopls = {
  --         cmd = { 'gopls', 'serve' },
  --         filetypes = { 'go' },
  --         settings = {
  --           gopls = {
  --             gofumpt = true,
  --             codelenses = {
  --               gc_details = false,
  --               generate = true,
  --               regenerate_cgo = true,
  --               run_govulncheck = true,
  --               test = true,
  --               tidy = true,
  --               upgrade_dependency = true,
  --               vendor = true,
  --             },
  --             hints = {
  --               assignVariableTypes = true,
  --               compositeLiteralFields = true,
  --               compositeLiteralTypes = true,
  --               constantValues = true,
  --               functionTypeParameters = true,
  --               parameterNames = true,
  --               rangeVariableTypes = true,
  --             },
  --             analyses = {
  --               fieldalignment = true,
  --               nilness = true,
  --               unusedparams = true,
  --               unusedwrite = true,
  --               useany = true,
  --             },
  --             usePlaceholders = true,
  --             completeUnimported = true,
  --             staticcheck = true,
  --             directoryFilters = { '-.git', '-.vscode', '-.idea', '-.vscode-test', '-node_modules' },
  --             semanticTokens = true,
  --           },
  --         },
  --       },
  --     },
  --     setup = { -- this is 'on_init = function() end'
  --       gopls = function(_, opts)
  --         -- workaround for gopls not supporting semanticTokensProvider
  --         -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
  --         if vim.lsp.client.name == 'gopls' and not vim.lsp.client.server_capabilities.semanticTokensProvider then
  --           local semantic = vim.lsp.client.config.capabilities.textDocument.semanticTokens
  --           vim.lsp.client.server_capabilities.semanticTokensProvider = {
  --             full = true,
  --             legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
  --             range = true,
  --           }
  --         end
  --       end,
  --     },
  --   },
  -- },
}
