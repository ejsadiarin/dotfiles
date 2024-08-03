local M = {}

---@param kind string
function M.pick(kind)
  return function()
    local actions = require("CopilotChat.actions")
    local items = actions[kind .. "_actions"]()
    if not items then
      LazyVim.warn("No " .. kind .. " found on the current line")
      return
    end
    local ok = pcall(require, "fzf-lua")
    require("CopilotChat.integrations." .. (ok and "fzflua" or "telescope")).pick(items)
  end
end

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    keys = {
      { "<leader>,ae", "<CMD>Copilot enable<CR>", desc = "Enable Copilot AI" },
    },
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",
          },
        },
      })
      vim.cmd("Copilot disable")
    end,
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    keys = {
      { "<leader>a", false },
      { "<leader>aa", false },
      { "<leader>ax", false },
      { "<leader>aq", false },
      { "<leader>ad", false },
      { "<leader>ap", false },

      { "<c-s>", "<CR>", ft = "copilot-chat", desc = "Submit Prompt", remap = true },
      { "<leader>,a", "", desc = "+ai", mode = { "n", "v" } },
      {
        "<leader>,aa",
        function()
          return require("CopilotChat").toggle()
        end,
        desc = "Toggle (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>,ax",
        function()
          return require("CopilotChat").reset()
        end,
        desc = "Clear (CopilotChat)",
        mode = { "n", "v" },
      },
      {
        "<leader>,aq",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input)
          end
        end,
        desc = "Quick Chat (CopilotChat)",
        mode = { "n", "v" },
      },
      -- Show help actions with telescope
      { "<leader>,ad", M.pick("help"), desc = "Diagnostic Help (CopilotChat)", mode = { "n", "v" } },
      -- Show prompts actions with telescope
      { "<leader>,ap", M.pick("prompt"), desc = "Prompt Actions (CopilotChat)", mode = { "n", "v" } },
    },
  },
}
