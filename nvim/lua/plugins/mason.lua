return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- Lua
      "lua-language-server",
      "stylua",
      -- Go
      "delve",
      "goimports",
      "gofumpt",
      -- Docker-related
      "docker-compose-language-service",
      "dockerfile-language-server",
      -- DevOps / Infra
      "terraform-ls",
      "yaml-language-server",
      "helm-ls",
      "marksman",
      -- Bash / Shell
      "shfmt",
      "bash-language-server",
      "shellcheck",
      -- Python
      "pyright",
      "black",
      "ruff-lsp",
      "debugpy",
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
      -- Rust
      "rust-analyzer",
      -- Others (JSON, TOML, etc.)
      "json-lsp",
      "codelldb",
      "taplo",
    },
  },
}
