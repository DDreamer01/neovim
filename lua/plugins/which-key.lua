-- ==========================================================================
--  Which-Key (Interactive Keybinding Discovery)
--  Shows popup cheatsheet as soon as you press Leader (<Space>)
-- ==========================================================================

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    preset = "modern",
    spec = {
      { "<leader>f", group = "Find / Telescope" },
      { "<leader>s", group = "Split Windows" },
      { "<leader>c", group = "Code / LSP" },
      { "<leader>h", group = "Git Hunks" },
      { "<leader>u", group = "UI Toggles" },
      { "<leader>t", group = "Terminal" },
    },
  },
}
