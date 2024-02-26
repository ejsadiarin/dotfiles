-- TODO: add custom snippets for various languages (Go, terraform, etc.)
return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })
        require("luasnip.loaders.from_snipmate").lazy_load({
          paths = vim.fn.stdpath("config") .. "/lua/plugins/snippets",
        })
      end,
    },
  },
}
