-- ==========================================================================
--  Dashboard (Welcome Page)
-- ==========================================================================

return {
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      theme = "hyper",
      config = {
        week_header = { enable = true },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          { desc = " Files",  group = "Label",      action = "Telescope find_files", key = "f" },
          { desc = " Recent", group = "Label",      action = "Telescope oldfiles",   key = "r" },
          { desc = " Config", group = "Label",      action = "e ~/.config/nvim/init.lua", key = "c" },
          { desc = " Quit",   group = "Label",      action = "qa", key = "q" },
        },
      },
    },
  },
}
