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
      { "<leader>f", group = "Find / Search (Files, Grep, TODOs)" },
      { "<leader>t", group = "Terminal (Float, Horizontal, Vertical)" },
      { "<leader>s", group = "Splits & Windows" },
      { "<leader>g", group = "Git & LazyGit" },
      { "<leader>c", group = "Code & LSP" },
      { "<leader>h", group = "Harpoon Marks" },
      { "<leader>x", group = "Diagnostics & Trouble" },
      { "<leader>u", group = "UI & Toggles (Cursor Smear, UndoTree)" },
    },
  },
}
