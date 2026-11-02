-- ==========================================================================
--  MDX Syntax & Treesitter Injections
-- ==========================================================================

return {
  {
    "davidmh/mdx.nvim",
    config = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    ft = { "mdx" },
  },
}
