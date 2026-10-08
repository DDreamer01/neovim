-- ==========================================================================
--  Cursor Animation Plugin (Smear Cursor)
--  Provides Neovide-like smooth cursor trailing animations in the terminal!
-- ==========================================================================

return {
  "sphamba/smear-cursor.nvim",
  event = "VeryLazy",
  cond = function()
    -- Only enable smear-cursor in terminal mode, since Neovide provides its own GPU cursor animation
    return not vim.g.neovide
  end,
  opts = {
    -- Animation stiffness & physics
    stiffness = 0.8,
    trailing_stiffness = 0.5,
    distance_stop_animating = 0.5,
    hide_target_hack = false,
  },
}
