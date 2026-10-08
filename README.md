# 🚀 Modern Neovim Configuration (IDE from Scratch)

A clean, blazing-fast, modular Neovim configuration built with Lua, designed for developers writing **Bash**, **Python**, and **Golang**. Features smooth **cursor animations** (both terminal-based and graphical), intelligent autocompletion, format-on-save, and interactive keybinding discovery.

Inspired by the [Neovim IDE from Scratch](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ) series by Christian Chiarulli / Typecraft, and the aesthetic workflow from [Magicalbat](https://www.youtube.com/watch?v=YM8Ftn3W0E0).

---

## ✨ Features

- **⚡ Blazing Fast Startup:** Modular plugin management powered by [lazy.nvim](https://github.com/folke/lazy.nvim).
- **🌀 Fluid Cursor Animation:**
  - **In Terminal (CLI / SSH):** [smear-cursor.nvim](https://github.com/sphamba/smear-cursor.nvim) brings physics-based cursor trailing animations to standard terminal emulators. Toggle anytime with `<Space>uc`.
  - **In GUI ([Neovide](https://neovide.dev)):** Native GPU hardware-accelerated railgun VFX particles and smooth trails matching Magicalbat's video setup.
- **🛠️ First-Class Language Support (Bash, Python, Golang):**
  - **Bash:** `bash-language-server` + `shellcheck` + `shfmt`
  - **Python:** `pyright` (types & completions) + `ruff` (linter & instant formatting)
  - **Golang:** `gopls` + `gofumpt` + `goimports`
  - **Lua:** `lua-language-server` + `stylua`
- **💾 Automated Formatting:** [conform.nvim](https://github.com/stevearc/conform.nvim) formats buffers automatically on save (`:w`) or on demand with `<Space>cf`.
- **🔎 Fuzzy Finder:** [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) with native C fzf acceleration for instant file and text search.
- **📁 File Explorer:** [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim) with git status indicators and directory folding (`<Space>e`).
- **💡 Interactive Keybinding Discovery:** [which-key.nvim](https://github.com/folke/which-key.nvim) automatically pops up keybinding hints whenever you press `<Space>`.
- **🎨 Aesthetics:** [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) (night style), [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) statusline, and [bufferline.nvim](https://github.com/akinsho/bufferline.nvim) editor tabs.

---

## 📂 Repository Structure

```text
~/.config/nvim/
├── init.lua                 # Core entry point (bootstraps lazy.nvim)
├── install.sh               # One-click installer for new machines
├── .gitignore               # Ignores swap, undo, and local cache files
├── README.md                # Documentation & keybinding reference
└── lua/
    ├── config/
    │   ├── options.lua      # Editor options (tabs, line numbers, clipboard, mouse)
    │   ├── keymaps.lua      # General navigation, splits, buffers, and terminal maps
    │   ├── autocmds.lua     # Yank highlight, auto-resize, filetype settings
    │   └── neovide.lua      # Neovide GPU cursor VFX and animations
    └── plugins/
        ├── cursor.lua       # Smear-cursor terminal physics animation
        ├── colorscheme.lua  # TokyoNight colorscheme theme
        ├── lsp.lua          # Mason & LSPConfig (Bash, Python, Go, Lua)
        ├── completion.lua   # nvim-cmp autocompletion & LuaSnip
        ├── treesitter.lua   # Treesitter syntax highlighting & incremental selection
        ├── telescope.lua    # Telescope fuzzy finder
        ├── filetree.lua     # Neo-tree file manager
        ├── statusline.lua   # Lualine bottom statusline
        ├── bufferline.lua   # Bufferline top tabline
        ├── formatting.lua   # Conform format-on-save (shfmt, ruff, gofumpt)
        ├── which-key.lua    # Popup keybinding cheat-sheet
        ├── git.lua          # Gitsigns gutter markers & hunk actions
        └── mini.lua         # Autopairs and line commenting (gcc)
```

---

## ⌨️ Keybindings Cheatsheet

> **Leader Key:** `Space` (`<leader>`)

### 🧭 Navigation & Core Shortcuts

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>` | Normal | Opens **Which-Key** visual shortcut cheat-sheet |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Normal | Move cursor across window splits (left / down / up / right) |
| `<C-d>` / `<C-u>` | Normal | Half-page jump down / up (keeps cursor centered) |
| `n` / `N` | Normal | Next / previous search result (keeps centered) |
| `<Esc>` or `<Space>nh` | Normal | Clear search highlighting |
| `<Space>w` | Normal | Save current file (`:w`) |
| `<Space>q` | Normal | Close current window (`:q`) |
| `<Space>Q` | Normal | Force quit all (`:qa!`) |
| `<Space>e` | Normal | Toggle Neo-tree file explorer |
| `<Space>tt` | Normal | Open bottom integrated terminal |
| `<Esc><Esc>` | Terminal | Exit terminal input mode to navigate buffer |

### 🖥️ Integrated Terminal (`<Space>t...` / `<C-\>`)

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>tt` | Normal | Toggle **Floating** centered terminal popup |
| `<Space>th` | Normal | Toggle **Horizontal** terminal split across bottom |
| `<Space>tv` | Normal | Toggle **Vertical** terminal split on right side |
| `<C-\>` | Normal/Term | Quick toggle active terminal |
| `jk` or `<Esc><Esc>` | Terminal | Exit terminal input mode to navigate buffer |

### 📑 Buffer Management (Tabs)

| Shortcut | Mode | Description |
|---|---|---|
| `<S-l>` / `]b` | Normal | Go to next buffer tab |
| `<S-h>` / `[b` | Normal | Go to previous buffer tab |
| `<Space>x` | Normal | Close current buffer (keeps window split intact) |

### 🪟 Window Splits (`<Space>s...`)

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>sv` | Normal | Split window vertically |
| `<Space>sh` | Normal | Split window horizontally |
| `<Space>se` | Normal | Make split sizes equal |
| `<Space>sx` | Normal | Close current split |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Normal | Navigate across window splits |
| `<C-Up>` / `<C-Down>` | Normal | Increase / decrease window height |
| `<C-Left>` / `<C-Right>` | Normal | Decrease / increase window width |

### 🔎 Search & Telescope (`<Space>f...`)

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>ff` | Normal | Find files in project |
| `<Space>fg` | Normal | Live grep (search text across all files) |
| `<Space>fb` | Normal | List open buffers |
| `<Space>fr` | Normal | Recent files |
| `<Space>ft` | Normal | Search **TODO** / FIXME / BUG comments |
| `<Space>fh` | Normal | Search Neovim help documentation |
| `<Space>fk` | Normal | Search all active keymaps |
| `<Space>fs` | Normal | Search LSP document symbols |

### 🐙 Git Integration (`<Space>g...` & `<Space>h...`)

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>gg` | Normal | Open **LazyGit** full interactive TUI modal |
| `<Space>hp` | Normal | Preview git hunk under cursor |
| `<Space>hs` | Normal/Visual | Stage hunk |
| `<Space>hr` | Normal/Visual | Reset hunk |
| `<Space>hb` | Normal | Blame line detail |
| `]c` / `[c` | Normal | Jump to next / previous git hunk |

### 🎯 Harpoon Quick Marks (`<Space>h...` / `<Space>1..4`)

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>ha` | Normal | Mark current file in Harpoon |
| `<Space>hh` | Normal | Open Harpoon quick menu |
| `<Space>1`..`<Space>4` | Normal | Jump directly to Harpoon pinned file 1, 2, 3, or 4 |

### 🩺 Diagnostics & Trouble (`<Space>x...`)

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>xx` | Normal | Toggle **Trouble** diagnostics list drawer |
| `<Space>xX` | Normal | Toggle buffer-local diagnostics |
| `<Space>xt` | Normal | Toggle TODOs drawer |
| `<Space>xQ` | Normal | Toggle Quickfix list |
| `<Space>d` | Normal | Show floating line diagnostic |
| `[d` / `]d` | Normal | Jump to previous / next diagnostic |

### 🧠 LSP & Code Intelligence (`<Space>c...`)

| Shortcut | Mode | Description |
|---|---|---|
| `K` | Normal | Show hover documentation / type signature |
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gi` | Normal | Go to implementation |
| `gr` | Normal | Find references |
| `<Space>rn` | Normal | Rename variable / symbol project-wide |
| `<Space>ca` | Normal | Code actions (fixes, quick-refactors) |
| `<Space>cf` | Normal/Visual | Format code with conform (shfmt / ruff / gofumpt) |

### ✏️ Editing & Visual Motions

| Shortcut | Mode | Description |
|---|---|---|
| `jk` | Insert / Terminal | Exit insert / terminal mode (replaces `ESC`) |
| `s` / `S` | Normal/Visual | **Flash** jump anywhere on screen instantly |
| `J` / `K` | Visual | Move selected lines down / up smoothly |
| `<` / `>` | Visual | Indent left / right (preserves selection) |
| `p` | Visual | Paste without replacing clipboard register |
| `gcc` | Normal | Toggle line comment |
| `gc` | Visual | Toggle comment on selected block |
| `<C-space>` | Normal | Expand Treesitter syntax selection |
| `<BS>` | Visual | Shrink Treesitter syntax selection |

### 🎛️ UI & Toggles (`<Space>u...`)

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>uc` | Normal | Toggle terminal **Smear-Cursor** animation on / off |
| `<Space>uu` | Normal | Toggle **UndoTree** visual branch history |

---

## 🌐 How to Store on GitHub

You can publish this exact configuration to your own GitHub repository with three simple commands:

1. Create a new repository on [GitHub](https://github.com/new) named `nvim-config` (or `dotfiles`).
2. Run in your terminal:
   ```bash
   cd ~/.config/nvim
   git remote add origin git@github.com:<YOUR_USERNAME>/<YOUR_REPO_NAME>.git
   git branch -M main
   git push -u origin main
   ```

---

## 💻 How to Replicate on Any Other Machine

To set up this entire configuration on a new laptop, desktop, or cloud server:

### Option A: The Fast 1-Liner (Automated Installer)
```bash
git clone https://github.com/<YOUR_USERNAME>/<YOUR_REPO_NAME>.git ~/.config/nvim
~/.config/nvim/install.sh
```

The `install.sh` script automatically:
1. Detects your distribution (Debian/Ubuntu, Arch, Fedora, macOS).
2. Installs required system tools (`ripgrep`, `fd`, C compiler, etc.).
3. Installs the latest stable Neovim release (>= 0.10.x).
4. Synchronizes plugins via `lazy.nvim`.
5. Pre-installs all language parsers and LSP servers in headless mode.

### Option B: Manual Setup
```bash
# 1. Clone into your config directory
git clone https://github.com/<YOUR_USERNAME>/<YOUR_REPO_NAME>.git ~/.config/nvim

# 2. Launch Neovim
nvim
```
Lazy.nvim will automatically download and install all plugins, and `mason-tool-installer` will install the LSP servers for Bash, Python, and Golang on the first start!
