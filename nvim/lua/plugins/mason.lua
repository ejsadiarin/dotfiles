-- Install and Configure LSP servers via 'mason-lspconfig'

return {

  {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    opts = {
      ensure_installed = {
        -- C
        'clangd',
      },
    },
  },
}
