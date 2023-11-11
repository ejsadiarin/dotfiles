return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      "stylua",
      "shfmt",
      "flake8",
      "pyright",
      "black",
      "netcoredbg",
      "tailwindcss-language-server",
      "typescript-language-server",
      "json-lsp",
      "lua-language-server",
      "codelldb",
      "clangd",
    },
  },
}
