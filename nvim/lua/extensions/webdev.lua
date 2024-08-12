-- Configures HTML, CSS, JavaScript, TypeScript, Tailwind support

return {
  {
    'pmizio/typescript-tools.nvim',
    ft = {
      'javascript',
      'javascriptreact',
      'javascript.jsx',
      'typescript',
      'typescriptreact',
      'typescript.tsx',
    },
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    opts = {},
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        tsserver = {},
        html = {},
        cssls = {},
        tailwindcss = {},
      },
      -- setup = {},
    },
  },

  {
    'williamboman/mason.nvim',
    opts = {
      ensure_installed = {
        -- HTML, CSS, JS, misc.
        'tsserver', -- javascript & typescript lsp
        'html-lsp', -- html lsp
        'html', -- html lsp
        'css-lsp', -- css lsp
        'cssls', -- css lsp
        'tailwindcss-language-server', -- tailwind lsp
        'tailwindcss', -- tailwind lsp
        'eslint_d', -- linter daemon
        'prettierd', -- formatter daemon
        'js-debug-adapter', -- debugger
      },
    },
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
}
