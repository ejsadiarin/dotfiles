-- Configures HTML, CSS, JavaScript, TypeScript, Tailwind support

return {
  {
    'yioneko/nvim-vtsls',
    filetypes = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
    configs = function(_, opts)
      require('lspconfig.configs').vtsls = require('vtsls').lspconfig -- set default server config, optional but recommended
      opts.settings.javascript = vim.tbl_deep_extend('force', {}, opts.settings.typescript, opts.settings.javascript or {})
      -- require('lspconfig').vtsls.setup { --[[ your custom server config here ]]
      -- }
    end,
  },

  -- {
  --   'neovim/nvim-lspconfig',
  --   opts = {
  --     servers = {
  --       tsserver = {
  --         enabled = false,
  --       },
  --       vtsls = {
  --         filetypes = {
  --           'javascript',
  --           'javascriptreact',
  --           'javascript.jsx',
  --           'typescript',
  --           'typescriptreact',
  --           'typescript.tsx',
  --         },
  --         settings = {
  --           complete_function_calls = true,
  --           vtsls = {
  --             enableMoveToFileCodeAction = true,
  --             autoUseWorkspaceTsdk = true,
  --             experimental = {
  --               completion = {
  --                 enableServerSideFuzzyMatch = true,
  --               },
  --             },
  --           },
  --           typescript = {
  --             updateImportsOnFileMove = { enabled = 'always' },
  --             suggest = {
  --               completeFunctionCalls = true,
  --             },
  --             inlayHints = {
  --               enumMemberValues = { enabled = true },
  --               functionLikeReturnTypes = { enabled = true },
  --               parameterNames = { enabled = 'literals' },
  --               parameterTypes = { enabled = true },
  --               propertyDeclarationTypes = { enabled = true },
  --               variableTypes = { enabled = false },
  --             },
  --           },
  --         },
  --       },
  --       html = {},
  --       cssls = {},
  --       tailwindcss = {},
  --     },
  --     setup = {
  --       tsserver = function()
  --         -- disable tsserver
  --         return true
  --       end,
  --       vtsls = function(_, opts)
  --         -- require('lspconfig.configs').vtsls = require('vtsls').lspconfig
  --         -- copy typescript settings to javascript
  --         -- opts.settings.javascript = vim.tbl_deep_extend('force', {}, opts.settings.typescript, opts.settings.javascript or {})
  --       end,
  --     },
  --   },
  -- },

  -- {
  --   'williamboman/mason.nvim',
  --   opts = {
  --     ensure_installed = {
  --       -- HTML, CSS, JS, misc.
  --       'tsserver', -- javascript & typescript lsp
  --       'html-lsp', -- html lsp
  --       'html', -- html lsp
  --       'css-lsp', -- css lsp
  --       'cssls', -- css lsp
  --       'tailwindcss-language-server', -- tailwind lsp
  --       'tailwindcss', -- tailwind lsp
  --       'eslint_d', -- linter daemon
  --       'prettierd', -- formatter daemon
  --       'js-debug-adapter', -- debugger
  --     },
  --   },
  -- },

  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      table.insert(opts.ensure_installed, {
        -- HTML, CSS, JS, misc.
        'tsserver', -- javascript & typescript lsp
        'vtsls', -- javascript & typescript lsp
        'emmet-language-server',
        'html-lsp', -- html lsp
        'css-lsp', -- css lsp
        'tailwindcss-language-server', -- tailwind lsp
        'eslint_d', -- linter daemon
        'prettierd', -- formatter daemon
        'js-debug-adapter', -- debugger
      })
    end,
  },

  -- {
  --   'WhoIsSethDaniel/mason-tool-installer.nvim',
  --   opts = {
  --     ensure_installed = {
  --       -- HTML, CSS, JS, misc.
  --       'tsserver', -- javascript & typescript lsp
  --       'html-lsp', -- html lsp
  --       'css-lsp', -- css lsp
  --       'tailwindcss-language-server', -- tailwind lsp
  --       'eslint_d', -- linter daemon
  --       'prettierd', -- formatter daemon
  --       'js-debug-adapter', -- debugger
  --     },
  --   },
  -- },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'html',
        'css',
        'javascript',
        'tsx',
        'typescript',
        'jsdoc',
      },
    },
  },

  {
    'jay-babu/mason-nvim-dap.nvim',
    opts = {
      -- automatic_installation = true,
      ensure_installed = {
        'js-debug-adapter', -- debugger
      },
    },
  },

  {
    'mfussenegger/nvim-lint',
    opts = {
      lint = {
        linters_by_ft = {
          javascript = { ' eslint_d' },
          typescript = { ' eslint_d' },
        },
      },
    },
  },
}
