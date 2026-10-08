-- ==========================================================================
--  Extended Developer Tools (Harpoon, Trouble, Undotree, Lazygit, Flash, etc.)
-- ==========================================================================

return {
  -- ── Flash (instant leap/jump navigation) ────────────────────
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash jump" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash treesitter" },
    },
  },

  -- ── Harpoon (quick buffer pinning & jumping) ───────────────
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>ha", function() require("harpoon"):list():add() end, desc = "Harpoon: add file" },
      { "<leader>hh", function() local h = require("harpoon"); h.ui:toggle_quick_menu(h:list()) end, desc = "Harpoon: menu" },
      { "<leader>1",  function() require("harpoon"):list():select(1) end, desc = "Harpoon file 1" },
      { "<leader>2",  function() require("harpoon"):list():select(2) end, desc = "Harpoon file 2" },
      { "<leader>3",  function() require("harpoon"):list():select(3) end, desc = "Harpoon file 3" },
      { "<leader>4",  function() require("harpoon"):list():select(4) end, desc = "Harpoon file 4" },
    },
    opts = {},
  },

  -- ── Trouble (visual diagnostics drawer) ────────────────────
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
      { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer diagnostics" },
      { "<leader>xt", "<cmd>Trouble todo toggle<CR>", desc = "TODOs (Trouble)" },
      { "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix list" },
    },
    opts = {},
  },

  -- ── Todo Comments (highlight & search TODOs) ───────────────
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next TODO" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Prev TODO" },
      { "<leader>ft", "<cmd>TodoTelescope<CR>", desc = "Find TODOs" },
    },
    opts = { signs = true },
  },

  -- ── Undotree (visual branch graph of undo history) ─────────
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<leader>uu", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
    },
  },

  -- ── LazyGit (interactive Git TUI modal) ────────────────────
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<CR>", desc = "LazyGit GUI" },
    },
  },

  -- ── Indent Guides ──────────────────────────────────────────
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
    },
  },

  -- ── Sticky Context Headers (current function pinned at top) 
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufReadPost",
    opts = {
      enable = true,
      max_lines = 3,
      trim_scope = "outer",
    },
  },
}
