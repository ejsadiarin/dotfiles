return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
    { "folke/neodev.nvim", opts = {} },
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "hrsh7th/cmp-nvim-lsp",
      cond = function()
        return require("lazyvim.util").has("nvim-cmp")
      end,
    },
  },
  opts = {
    servers = {
      tsserver = {
        handlers = {
          ["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
            -- your format-ts-errors.nvim handler code here.. (Pretty TS Errors)
            if result.diagnostics == nil then
              return
            end

            -- ignore some tsserver diagnostics
            local idx = 1
            while idx <= #result.diagnostics do
              local entry = result.diagnostics[idx]

              local formatter = require("format-ts-errors")[entry.code]
              entry.message = formatter and formatter(entry.message) or entry.message

              -- codes: https://github.com/microsoft/TypeScript/blob/main/src/compiler/diagnosticMessages.json
              if entry.code == 80001 then
                -- { message = "File is a CommonJS module; it may be converted to an ES module.", }
                table.remove(result.diagnostics, idx)
              else
                idx = idx + 1
              end
            end

            vim.lsp.diagnostic.on_publish_diagnostics(_, result, ctx, config)
          end,
        },
      },
    },
  },

  -- {
  -- if tsserver is slow:
  -- https://www.reddit.com/r/neovim/comments/14fdyjk/typescripttoolsnvim_the_typescript_integration/
  -- "pmizio/typescript-tools.nvim",
  -- dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  -- opts = {},
  -- },
}
