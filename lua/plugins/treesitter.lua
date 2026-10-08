-- ==========================================================================
--  Treesitter Syntax Highlighting & Code Parsing
-- ==========================================================================

return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = {
    ensure_installed = {
      "bash",
      "python",
      "go",
      "gomod",
      "gowork",
      "gosum",
      "lua",
      "vim",
      "vimdoc",
      "json",
      "yaml",
      "toml",
      "markdown",
      "markdown_inline",
      "c",
    },
    sync_install = false,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
      disable = { "python" },
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = false,
        node_decremental = "<bs>",
      },
    },
  },
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
