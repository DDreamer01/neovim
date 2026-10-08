-- ==========================================================================
--  Neovim Core Initialization File
--  Clean, Modular, Fast, and Reproducible (Typecraft / Chris@Machine style)
-- ==========================================================================

-- Map leader keys to Space before anything else (crucial for lazy.nvim mappings)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core settings, mappings, autocommands, and Neovide GUI preferences
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("config.neovide")

-- Bootstrap lazy.nvim plugin manager if not present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Configure and load plugins from lua/plugins/*.lua
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false,
  },
  install = {
    colorscheme = { "tokyonight" },
  },
  checker = {
    enabled = false, -- Don't nag on startup
  },
  rocks = {
    enabled = false, -- Disable luarocks as plugins are git-managed
  },
  change_detection = {
    notify = false,
  },
  ui = {
    border = "rounded",
  },
})
