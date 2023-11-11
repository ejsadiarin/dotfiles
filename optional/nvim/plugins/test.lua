return {
  { "nvim-neotest/neotest-plenary" },
  { "Issafalcon/neotest-dotnet" },
  {
    "nvim-neotest/neotest",
    opts = {
      adapters = {
        "neotest-plenary",

        -- https://github.com/Issafalcon/neotest-dotnet#usage
        "neotest-dotnet",
      },
    },
  },
}
