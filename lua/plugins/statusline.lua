-- ==========================================================================
--  Lualine Statusline
-- ==========================================================================

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "tokyonight",
      globalstatus = true, -- Single statusline across all window splits
      component_separators = { left = "|", right = "|" },
      section_separators = { left = "", right = "" },
      disabled_filetypes = { statusline = { "dashboard", "alpha", "neo-tree" } },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff" },
      lualine_c = {
        {
          "filename",
          path = 1, -- Relative path
          symbols = { modified = " ●", readonly = " ", unnamed = "[No Name]" },
        },
      },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
        },
        "encoding",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
