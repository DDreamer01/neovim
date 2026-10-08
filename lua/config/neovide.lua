-- ==========================================================================
--  Neovide GUI Configuration
--  Provides the exact smooth cursor animations seen in Magicalbat's videos
--  (https://www.youtube.com/watch?v=YM8Ftn3W0E0)
-- ==========================================================================

if vim.g.neovide then
  -- Smooth cursor animations
  vim.g.neovide_cursor_animation_length = 0.13      -- Time (in seconds) cursor takes to travel
  vim.g.neovide_cursor_trail_size = 0.8             -- Length of the trailing smear behind the cursor
  vim.g.neovide_cursor_antialiasing = true          -- Smooth font rendering
  vim.g.neovide_cursor_animate_in_insert_mode = true
  vim.g.neovide_cursor_animate_command_line = true

  -- Visual cursor particle effects (VFX)
  -- Options: "railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe", ""
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_cursor_vfx_opacity = 200.0
  vim.g.neovide_cursor_vfx_particle_speed = 20.0
  vim.g.neovide_cursor_vfx_particle_density = 7.0
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2

  -- Smooth scrolling
  vim.g.neovide_scroll_animation_length = 0.3
  vim.g.neovide_scroll_animation_far_lines = 1

  -- Window transparency and padding
  vim.g.neovide_transparency = 0.96
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0
  vim.g.neovide_floating_shadow = true
  vim.g.neovide_floating_z_height = 10
  vim.g.neovide_light_angle_degrees = 45
  vim.g.neovide_light_radius = 5

  -- Padding around edges
  vim.g.neovide_padding_top = 8
  vim.g.neovide_padding_bottom = 8
  vim.g.neovide_padding_right = 10
  vim.g.neovide_padding_left = 10

  -- Refresh rate & input
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_remember_window_size = true

  -- Keybindings for zoom inside Neovide
  vim.keymap.set({ "n", "v" }, "<C-=>", function()
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) * 1.1
  end, { desc = "Neovide zoom in" })
  vim.keymap.set({ "n", "v" }, "<C-->", function()
    vim.g.neovide_scale_factor = (vim.g.neovide_scale_factor or 1.0) * 0.9
  end, { desc = "Neovide zoom out" })
  vim.keymap.set({ "n", "v" }, "<C-0>", function()
    vim.g.neovide_scale_factor = 1.0
  end, { desc = "Neovide reset zoom" })
end
