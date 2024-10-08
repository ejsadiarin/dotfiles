return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        marksman = {},
      },
    },
  },

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        -- Markdown
        'marksman', -- lsp
        -- 'markdownlint-cli2', -- linter
        'markdown-toc', -- table of contents formatter
      },
    },
  },

  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        'markdown',
        'markdown_inline',
      },
    },
  },

  -- optional (personally nah)
  -- {
  --   'mfussenegger/nvim-lint',
  --   opts = {
  --     linters_by_ft = {
  --       markdown = { 'markdownlint-cli2' },
  --     }
  --   }
  -- },
}
