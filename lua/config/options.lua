-- ==========================================================================
--  Editor Options & General Behavior
-- ==========================================================================

local opt = vim.opt

-- Line numbers
opt.number = true             -- Show absolute line number on the current line
opt.relativenumber = true     -- Show relative line numbers for quick jumping (e.g. 5j, 10k)
opt.numberwidth = 4           -- Width of the line number column

-- Tabs & Indentation
opt.tabstop = 4               -- 1 tab = 4 spaces
opt.softtabstop = 4           -- Editing operations (Backspace) delete 4 spaces
opt.shiftwidth = 4            -- Indent with 4 spaces (>> and <<)
opt.expandtab = true          -- Convert tabs to spaces
opt.autoindent = true         -- Keep indent from current line on new line
opt.smartindent = true        -- Insert indent automatically according to syntax rules

-- Search settings
opt.ignorecase = true         -- Ignore case when searching...
opt.smartcase = true          -- ...unless search pattern contains an uppercase character
opt.hlsearch = true           -- Highlight all matches on search
opt.incsearch = true          -- Show matches incrementally as you type

-- Cursor, View & Scrolling
opt.cursorline = true         -- Highlight the line under the cursor
opt.termguicolors = true      -- Enable 24-bit RGB true colors
opt.signcolumn = "yes"        -- Always show signcolumn (avoids text shifting when LSP/git loads)
opt.scrolloff = 8             -- Keep 8 lines visible above/below the cursor when scrolling
opt.sidescrolloff = 8         -- Keep 8 columns visible to the sides
opt.wrap = false              -- Do not wrap long lines horizontally

-- Clipboard & Mouse
opt.clipboard = "unnamedplus" -- Sync with system clipboard (yank/paste works across OS/apps)
opt.mouse = "a"               -- Enable full mouse support (click, resize, scroll)

-- Window splitting
opt.splitbelow = true         -- Horizontal splits automatically open below current window
opt.splitright = true         -- Vertical splits automatically open to the right

-- File history & Backups
opt.swapfile = false          -- Disable swap files (prevents annoying .swp prompt crashes)
opt.backup = false            -- Disable backup file creation
opt.writebackup = false       -- Do not keep backup after overwriting a file
opt.undofile = true           -- Enable persistent undo history across editor restarts

-- Timing & Responsiveness
opt.updatetime = 250          -- Faster completion & gitsigns refresh (default is 4000ms)
opt.timeoutlen = 300          -- Faster which-key and leader shortcut trigger

-- Appearance & Completion popups
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 10            -- Max items to display in completion popup menu
opt.showmode = false          -- Do not show mode (e.g. -- INSERT --) because statusline shows it

-- Font (used if running in GUI like Neovide)
opt.guifont = "JetBrainsMono Nerd Font,FiraCode Nerd Font,monospace:h12"

-- Providers
vim.g.python3_host_prog = "/usr/bin/python3"
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- Custom Filetype Detection & Tree-sitter Setup
vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})

-- Tree-sitter directive & range compatibility shim for Neovim 0.10+ / 0.12
-- In Neovim 0.10+, tree-sitter directive handlers receive captures as `table<integer, TSNode[]>`.
-- Legacy directives (such as nvim-treesitter's set-lang-from-info-string! and downcase!) expect
-- TSNode instead of TSNode[] (tables), causing 'attempt to call method range (a nil value)'.
local orig_add_directive = vim.treesitter.query.add_directive
vim.treesitter.query.add_directive = function(name, handler, opts)
  local wrapped_handler = function(match, pattern, bufnr, pred, metadata)
    local unwrap_match = setmetatable({}, {
      __index = function(_, k)
        local val = match[k]
        if type(val) == "table" and val[1] and type(val[1]) == "userdata" then
          return val[1]
        end
        return val
      end,
      __newindex = function(_, k, v)
        match[k] = v
      end,
      __pairs = function()
        local next_fn, t, k = pairs(match)
        return function(_, key)
          local nk, nv = next_fn(t, key)
          if type(nv) == "table" and nv[1] and type(nv[1]) == "userdata" then
            nv = nv[1]
          end
          return nk, nv
        end, t, k
      end,
    })
    return handler(unwrap_match, pattern, bufnr, pred, metadata)
  end
  return orig_add_directive(name, wrapped_handler, opts)
end

-- Safely unwrap if a node table { TSNode } is passed to get_range or get_node_text
local orig_get_range = vim.treesitter.get_range
vim.treesitter.get_range = function(node, source, metadata)
  if type(node) == "table" and node[1] then
    node = node[1]
  end
  return orig_get_range(node, source, metadata)
end

local orig_get_node_text = vim.treesitter.get_node_text
vim.treesitter.get_node_text = function(node, source, opts)
  if type(node) == "table" and node[1] then
    node = node[1]
  end
  return orig_get_node_text(node, source, opts)
end

-- Register markdown parser for mdx files
vim.treesitter.language.register("markdown", "mdx")
