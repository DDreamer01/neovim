-- ==========================================================================
--  Telescope Fuzzy Finder
-- ==========================================================================

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep (search text)" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find open buffers" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help tags & docs" },
    { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Search keymaps" },
    { "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "Document symbols" },
    { "<leader>/",  "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Fuzzy search in current buffer" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = "   ",
        selection_caret = "  ",
        path_display = { "truncate" },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<Esc>"] = actions.close,
          },
        },
      },
    })

    -- Load fzf native extension if built
    pcall(telescope.load_extension, "fzf")
  end,
}
