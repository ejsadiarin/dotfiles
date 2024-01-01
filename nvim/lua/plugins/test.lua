return {
  { "nvim-neotest/neotest-plenary" },
  { "Issafalcon/neotest-dotnet" },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-go",
    },
    opts = {
      adapters = {
        "neotest-plenary",

        -- https://github.com/Issafalcon/neotest-dotnet#usage
        "neotest-dotnet",
      },
    },
  },
}
