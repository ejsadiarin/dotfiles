local lspconfig = require 'lspconfig'
local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

-- lua_ls = {
--   -- cmd = {...},
--   -- filetypes = { ...},
--   -- capabilities = {},
--   settings = {
--     Lua = {
--       completion = {
--         callSnippet = 'Replace',
--       },
--       -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
--       diagnostics = { disable = { 'missing-fields' } },
--     },
--   },
-- },
lspconfig.lua_ls.setup {
  capabilities = lsp_capabilities,
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
      },
      telemetry = {
        enable = false,
      },
      diagnostics = { disable = { 'missing-fields' } },
      -- workspace = {
      --   checkThirdParty = false
      -- },
    },
  },
}
