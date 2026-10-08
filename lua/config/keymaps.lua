-- ==========================================================================
--  Keybindings & Shortcuts
-- ==========================================================================

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key to Space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- -------------------------------------------------------------------------
-- General & Navigation
-- -------------------------------------------------------------------------

-- Clear search highlights with <leader>nh or pressing <Esc> in normal mode
keymap("n", "<leader>nh", ":nohlsearch<CR>", { desc = "Clear search highlight", silent = true })
keymap("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Escape and clear highlight", silent = true })

-- Keep cursor centered during half-page jumps
keymap("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keep search results centered in the screen
keymap("n", "n", "nzzzv", { desc = "Next search result (centered)" })
keymap("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- Fast file save and quit
keymap("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })
keymap("n", "<leader>Q", "<cmd>qa!<CR>", { desc = "Force quit all" })

-- -------------------------------------------------------------------------
-- Window / Split Navigation & Management
-- -------------------------------------------------------------------------

-- Navigate windows easily using Ctrl + h/j/k/l (replaces <C-w>h, etc.)
keymap("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Split management (<leader>s...)
keymap("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Resize windows with Ctrl + arrow keys
keymap("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
keymap("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
keymap("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })
keymap("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })

-- -------------------------------------------------------------------------
-- Buffer Navigation (Tabs)
-- -------------------------------------------------------------------------

-- Cycle through open buffers with Shift + l (next) and Shift + h (prev)
keymap("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer tab" })
keymap("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer tab" })
keymap("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
keymap("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })

-- Close current buffer safely without closing window split
keymap("n", "<leader>x", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_get_option_value("modified", { buf = bufnr })
  if modified then
    local choice = vim.fn.confirm("Buffer has unsaved changes. Save before closing?", "&Yes\n&No\n&Cancel")
    if choice == 1 then
      vim.cmd("write")
    elseif choice == 3 or choice == 0 then
      return
    end
  end
  vim.cmd("bprevious | bdelete! " .. bufnr)
end, { desc = "Close buffer" })

-- -------------------------------------------------------------------------
-- Insert Mode Ergonomics
-- -------------------------------------------------------------------------

-- Map jk to ESC to quickly return to Normal mode
keymap("i", "jk", "<ESC>", { desc = "Exit insert mode" })

-- -------------------------------------------------------------------------
-- Visual Mode Editing Ergonomics
-- -------------------------------------------------------------------------

-- Move selected lines up/down smoothly with J/K or Alt+j/Alt+k
keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Stay in indent mode when indenting multiple times with < and >
keymap("v", "<", "<gv", { desc = "Indent left and keep selection" })
keymap("v", ">", ">gv", { desc = "Indent right and keep selection" })

-- Paste over selection without losing current pasteboard register
keymap("v", "p", '"_dP', { desc = "Paste without overwriting register" })

-- -------------------------------------------------------------------------
-- Terminal Ergonomics
-- -------------------------------------------------------------------------

-- Quick escape from terminal insert mode back to normal mode with Esc Esc or jk
keymap("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal insert mode" })
keymap("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal insert mode with jk" })

-- Terminal window navigation
keymap("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Terminal: focus left" })
keymap("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Terminal: focus down" })
keymap("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Terminal: focus up" })
keymap("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Terminal: focus right" })

-- Toggle integrated terminal split (<leader>tt)
keymap("n", "<leader>tt", function()
  vim.cmd("botright 14split | terminal")
  vim.cmd("startinsert")
end, { desc = "Open bottom terminal" })

-- -------------------------------------------------------------------------
-- Cursor Animation Toggle
-- -------------------------------------------------------------------------
keymap("n", "<leader>uc", function()
  local ok, smear = pcall(require, "smear_cursor")
  if ok then
    smear.toggle()
  else
    vim.notify("smear-cursor is not loaded", vim.log.levels.WARN)
  end
end, { desc = "Toggle cursor smear animation" })
