return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("lazyvim.util").has("nvim-cmp")
        end,
      },
    },
    -- config = function()
    --   -- add borders to lsp info window
    --   require("lspconfig.ui.windows").default_options.border = "single"
    -- end,
    opts = {
      ui = {
        windows = {
          border = "rounded",
        },
      },
      servers = {
        ansiblels = {},
        yamlls = {
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas()
            )
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
            },
          },
        },
        helm_ls = {},
        -- tsserver = {
        --   handlers = {
        --     ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
        --       -- your format-ts-errors.nvim handler code here.. (Pretty TS Errors)
        --       if result.diagnostics == nil then
        --         return
        --       end
        --
        --       -- ignore some tsserver diagnostics
        --       local idx = 1
        --       while idx <= #result.diagnostics do
        --         local entry = result.diagnostics[idx]
        --
        --         local formatter = require("format-ts-errors")[entry.code]
        --         entry.message = formatter and formatter(entry.message) or entry.message
        --
        --         -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
        --         if entry.code == 80001 then
        --           -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
        --           table.remove(result.diagnostics, idx)
        --         else
        --           idx = idx + 1
        --         end
        --       end
        --
        --       vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
        --     end,
        --   },
        -- },
      },
      setup = {
        yamlls = function()
          -- Neovim < 0.10 does not have dynamic registration for formatting
          if vim.fn.has("nvim-0.10") == 0 then
            LazyVim.lsp.on_attach(function(client, _)
              if client.name == "yamlls" then
                client.server_capabilities.documentFormattingProvider = true
              end
            end)
          end
        end,
      },
    },
  },

  {
    "someone-stole-my-name/yaml-companion.nvim",
    ft = { "yaml" },
    opts = {
      builtin_matchers = {
        kubernetes = { enabled = true },
      },
    },
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function(_, opts)
      local cfg = require("yaml-companion").setup(opts)
      require("lspconfig")["yamlls"].setup(cfg)
      require("telescope").load_extension("yaml_schema")
    end,
  },

  -- {
  -- if tsserver is slow:
  -- https://www.reddit.com/r/neovim/comments/14fdyjk/typescripttoolsnvim_the_typescript_integration/
  -- "pmizio/typescript-tools.nvim",
  -- dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  -- opts = {},
  -- },
}
