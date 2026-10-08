-- ==========================================================================
--  Code Formatter (Conform.nvim)
--  Fast, reliable format-on-save for Bash, Python, and Golang
-- ==========================================================================

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer or selection",
    },
  },
  opts = {
    formatters_by_ft = {
      bash = { "shfmt" },
      sh = { "shfmt" },
      python = { "ruff_format", "ruff_organize_imports" },
      go = { "gofumpt", "goimports" },
      lua = { "stylua" },
      json = { "prettier", stop_after_first = true },
      yaml = { "prettier", stop_after_first = true },
      markdown = { "prettier", stop_after_first = true },
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
  },
}
