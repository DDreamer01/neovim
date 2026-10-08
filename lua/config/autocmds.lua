-- ==========================================================================
--  Autocommands
-- ==========================================================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general_group = augroup("GeneralSettings", { clear = true })

-- 1. Highlight briefly on yank (gives satisfying visual feedback when copying text)
autocmd("TextYankPost", {
  group = general_group,
  desc = "Highlight text when yanked",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
  end,
})

-- 2. Restore last cursor position when reopening a file
autocmd("BufReadPost", {
  group = general_group,
  desc = "Return to last edit position",
  callback = function(args)
    local valid_line = vim.fn.line([['"]]) >= 1 and vim.fn.line([['"]]) <= vim.fn.line("$")
    local not_commit = vim.b[args.buf].filetype ~= "gitcommit"
    if valid_line and not_commit then
      vim.cmd([[normal! g`"]])
    end
  end,
})

-- 3. Auto-resize splits when host terminal window is resized
autocmd("VimResized", {
  group = general_group,
  desc = "Equalize splits on window resize",
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- 4. Do not auto-continue comments onto the next line with 'o' or 'Enter'
autocmd("BufEnter", {
  group = general_group,
  desc = "Disable auto-commenting on new line",
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- 5. Close specific filetypes with a simple 'q'
autocmd("FileType", {
  group = general_group,
  pattern = {
    "qf",
    "help",
    "man",
    "notify",
    "lspinfo",
    "checkhealth",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- 6. Filetype-specific indentation
local ft_group = augroup("FileTypeIndents", { clear = true })
autocmd("FileType", {
  group = ft_group,
  pattern = { "lua", "javascript", "typescript", "json", "yaml", "html", "css", "markdown" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Golang indentation convention: tabs
autocmd("FileType", {
  group = ft_group,
  pattern = { "go", "gomod" },
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})
