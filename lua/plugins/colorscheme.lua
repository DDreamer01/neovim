-- ==========================================================================
--  TokyoNight Colorscheme
-- ==========================================================================

return {
  "folke/tokyonight.nvim",
  priority = 1000, -- Highest priority to ensure colorscheme applies immediately
  lazy = false,
  opts = {
    style = "night", -- Styles: 'storm', 'moon', 'night', 'day'
    transparent = false,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "dark",
      floats = "dark",
    },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)
    vim.cmd("colorscheme tokyonight")
  end,
}
