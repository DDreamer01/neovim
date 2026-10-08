-- ==========================================================================
--  ToggleTerm: Floating, Horizontal, and Vertical Terminal Manager
-- ==========================================================================

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm direction=float<CR>",      desc = "Float terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Horizontal terminal split" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",   desc = "Vertical terminal split" },
    { "<C-\\>",     "<cmd>ToggleTerm<CR>",                      desc = "Toggle terminal", mode = { "n", "t" } },
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return 14
      elseif term.direction == "vertical" then
        return math.floor(vim.o.columns * 0.4)
      end
    end,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    float_opts = {
      border = "curved",
      winblend = 0,
    },
  },
}
