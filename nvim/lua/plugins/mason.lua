return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- Lua
      "lua-language-server",
      "stylua",
      --Shell
      "shfmt",
      -- Python
      "flake8",
      "pyright",
      "black",
      "ruff-lsp",
      -- C#
      "omnisharp",
      "netcoredbg",
      "csharpier",
      -- HTML / CSS
      "tailwindcss-language-server",
      "html-lsp",
      "css-lsp",
      "emmet-ls",
      -- JavaScript / TypeScript
      "typescript-language-server",
      "js-debug-adapter",
      "eslint-lsp",
      -- C / C++
      "clangd",
      -- Go
      "delve",
      "goimports",
      "gofumpt",
      -- Rust
      "rust-analyzer",
      -- Docker-related
      "docker-compose-language-service",
      "dockerfile-language-server",
      -- Others (JSON, TOML, etc.)
      "json-lsp",
      "codelldb",
      "taplo",
    },
  },
}
