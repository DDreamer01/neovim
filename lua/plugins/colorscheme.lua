-- ==========================================================================
--  TokyoNight Colorscheme
-- ==========================================================================

return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      style = "night",
      transparent = true,        -- Inherit terminal (Kitty) background
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        -- Don't set background on sidebars/floats either
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight")
      -- Ensure Normal and NormalNC have no background so the terminal bg shows through
      vim.api.nvim_set_hl(0, "Normal",   { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
      vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
      vim.api.nvim_set_hl(0, "LineNr",   { bg = "none" })
      vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })
    end,
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = {
      flavour = "mocha",
    },
  },
}
