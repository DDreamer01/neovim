<div align="center">

# ⚡ The Dreamer's Neovim IDE

### *A High-Performance, Modular Neovim Development Environment with Fluid Motion Physics*

[![Neovim](https://img.shields.io/badge/Neovim-0.10%2B-57A143?style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io)
[![Configured in Lua](https://img.shields.io/badge/Config-Lua%205.1-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org)
[![Python](https://img.shields.io/badge/Python-3.11%2B-3776AB?style=for-the-badge&logo=python&logoColor=white)](https://python.org)
[![Golang](https://img.shields.io/badge/Golang-1.21%2B-00ADD8?style=for-the-badge&logo=go&logoColor=white)](https://go.dev)
[![Bash](https://img.shields.io/badge/Bash-Shell-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)

[![Package Manager](https://img.shields.io/badge/Plugin%20Manager-lazy.nvim-8A2BE2?style=for-the-badge&logo=packer&logoColor=white)](https://github.com/folke/lazy.nvim)
[![Theme: TokyoNight](https://img.shields.io/badge/Theme-TokyoNight-1a1b26?style=for-the-badge&logo=gnome-terminal&logoColor=7aa2f7)](https://github.com/folke/tokyonight.nvim)
[![Theme: Catppuccin](https://img.shields.io/badge/Theme-Catppuccin-cdd6f4?style=for-the-badge&logo=catppuccin&logoColor=1e1e2e)](https://github.com/catppuccin/nvim)
[![Motion: Smear Cursor](https://img.shields.io/badge/Motion-Smear_Cursor-ff9e64?style=for-the-badge&logo=render&logoColor=white)](https://github.com/sphamba/smear-cursor.nvim)
[![GUI: Neovide](https://img.shields.io/badge/GUI-Neovide%20Railgun-00C7FF?style=for-the-badge&logo=speedtest&logoColor=white)](https://neovide.dev)

[![Repo Size](https://img.shields.io/github/repo-size/DDreamer01/neovim?style=flat-square&color=blue)](https://github.com/DDreamer01/neovim)
[![Stars](https://img.shields.io/github/stars/DDreamer01/neovim?style=flat-square&color=yellow)](https://github.com/DDreamer01/neovim)
[![Last Commit](https://img.shields.io/github/last-commit/DDreamer01/neovim?style=flat-square&color=green)](https://github.com/DDreamer01/neovim)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square)](https://opensource.org/licenses/MIT)

</div>

---

A modern, blazing-fast, and modular Neovim configuration built with Lua. Tailored specifically for writing **Bash**, **Python**, and **Golang**, with real-world cursor physics animations (in terminal and Neovide), complete LSP intelligence, automated format-on-save, and interactive keybinding discovery.

Inspired by Christian Chiarulli’s [Neovim IDE from Scratch](https://www.youtube.com/watch?v=ctH-a-1eUME&list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ) and the visual aesthetics from [Magicalbat](https://www.youtube.com/watch?v=YM8Ftn3W0E0).

---

## ⚡ 1-Liner Quick Replicate

To clone and set up this entire configuration on any new machine (Ubuntu/Debian, Arch, Fedora, or macOS):

```bash
git clone https://github.com/DDreamer01/neovim.git ~/.config/nvim && ~/.config/nvim/install.sh
```

---

## ✨ Features & Ecosystem

### 🌀 Fluid Cursor Animation & Motion
- **In the Terminal (CLI / SSH):** Integrated [`smear-cursor.nvim`](https://github.com/sphamba/smear-cursor.nvim) provides physics-based trailing smear animations across all jumps and edits. Toggle anytime with `<Space>uc`.
- **In Graphical GUI ([Neovide](https://neovide.dev)):** Native GPU hardware acceleration with railgun VFX particle bursts and spring-eased trailing lines configured in [`lua/config/neovide.lua`](lua/config/neovide.lua).
- **Fast Jump:** [`flash.nvim`](https://github.com/folke/flash.nvim) allows two-key teleportation across the viewport (`s` / `S`).

### 🛠️ First-Class Language Toolchains
- **Bash:** Treesitter parser + `bash-language-server` + `shellcheck` + `shfmt`
- **Python:** Treesitter parser + `pyright` (types & completions) + `ruff` (linter & instant formatting)
- **Golang:** Treesitter parsers (`go`, `gomod`, `gowork`, `gosum`) + `gopls` + `gofumpt` + `goimports`
- **Lua:** `lua-language-server` + `stylua` + `lazydev.nvim`
- **Format-on-Save:** [`conform.nvim`](https://github.com/stevearc/conform.nvim) formats buffers automatically on `:w` or via `<Space>cf`.
- **Mason Package Manager:** `mason-tool-installer` ensures all language servers and formatters are pre-installed automatically on first run.

### 🎛️ Full Developer Power Tools
- **Terminal Management:** [`toggleterm.nvim`](https://github.com/akinsho/toggleterm.nvim) with floating modal (`<Space>tt`), horizontal split (`<Space>th`), and vertical split (`<Space>tv`).
- **Git Integration:** Full interactive [`lazygit.nvim`](https://github.com/kdheepak/lazygit.nvim) modal (`<Space>gg`) + [`gitsigns.nvim`](https://github.com/lewis6991/gitsigns.nvim) inline hunk actions (`<Space>hs`, `<Space>hp`, `<Space>hr`).
- **File Pinning:** [`harpoon2`](https://github.com/ThePrimeagen/harpoon) for instant 4-buffer switching (`<Space>ha`, `<Space>hh`, `<Space>1`..`<Space>4`).
- **Diagnostics Drawer:** [`trouble.nvim`](https://github.com/folke/trouble.nvim) (`<Space>xx`) and [`todo-comments.nvim`](https://github.com/folke/todo-comments.nvim) (`<Space>xt`, `<Space>ft`).
- **Fuzzy Finding:** [`telescope.nvim`](https://github.com/nvim-telescope/telescope.nvim) with native C FZF sorting (`<Space>ff`, `<Space>fg`, `<Space>fb`).
- **Visual Undo Graph:** [`undotree`](https://github.com/mbbill/undotree) (`<Space>uu`).
- **Dual Themes:** **TokyoNight** (default) and **Catppuccin Mocha** (switch via `:colorscheme catppuccin`).

---

## 📂 Architecture

```text
~/.config/nvim/
├── init.lua                 # Core entry point (bootstraps lazy.nvim)
├── install.sh               # Cross-platform automated setup script
├── .gitignore               # Ignores swap, undo, and local cache files
├── README.md                # Documentation & keybinding guide
└── lua/
    ├── config/
    │   ├── options.lua      # Line numbers, tabs, clipboard, mouse, undo
    │   ├── keymaps.lua      # General navigation, splits, and 'jk' escape mapping
    │   ├── autocmds.lua     # Yank highlight, auto-resize, sh->bash mapping
    │   └── neovide.lua      # Neovide GPU cursor VFX and animations
    └── plugins/
        ├── cursor.lua       # Smear-cursor terminal physics animation
        ├── colorscheme.lua  # TokyoNight & Catppuccin Mocha themes
        ├── lsp.lua          # Mason, mason-tool-installer, nvim-lspconfig
        ├── completion.lua   # nvim-cmp autocompletion, LuaSnip, lspkind
        ├── treesitter.lua   # Treesitter syntax highlighting & textobjects
        ├── telescope.lua    # Telescope fuzzy finder + FZF native
        ├── filetree.lua     # Neo-tree file manager (<Space>e)
        ├── terminal.lua     # ToggleTerm (floating, horizontal, vertical)
        ├── tools.lua        # Harpoon2, Trouble, Todo-comments, LazyGit, Flash, UndoTree
        ├── statusline.lua   # Lualine bottom statusline
        ├── bufferline.lua   # Bufferline top tabline (<S-l>, <S-h>, <Space>x)
        ├── formatting.lua   # Conform format-on-save (shfmt, ruff, gofumpt)
        ├── which-key.lua    # Interactive keybinding discovery popup
        ├── git.lua          # Gitsigns gutter decorations & hunk staging
        └── mini.lua         # Autopairs and line commenting (gcc)
```

---

## ⌨️ Keybindings Cheat-Sheet

> **Leader Key:** `Space` (`<leader>`)  
> **Interactive Helper:** Press `<Space>` and pause for 300ms to open **Which-Key**!

### 🖥️ Integrated Terminal (`<Space>t...` / `<C-\>`)

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>tt` | Normal | Toggle **Floating** centered terminal popup |
| `<Space>th` | Normal | Toggle **Horizontal** terminal split across bottom |
| `<Space>tv` | Normal | Toggle **Vertical** terminal split on right side |
| `<C-\>` | Normal/Term | Quick toggle active terminal |
| `jk` or `<Esc><Esc>` | Terminal | Exit terminal input mode to navigate buffer |

### 🎯 Harpoon Quick Marks (`<Space>h...` / `<Space>1..4`)

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>ha` | Normal | Pin current file to Harpoon |
| `<Space>hh` | Normal | Open Harpoon quick-menu |
| `<Space>1`..`<Space>4` | Normal | Jump directly to Harpoon pinned file 1, 2, 3, or 4 |

### 🐙 Git Integration (`<Space>g...` & `<Space>h...`)

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>gg` | Normal | Open **LazyGit** interactive TUI modal |
| `<Space>hp` | Normal | Preview git hunk under cursor |
| `<Space>hs` | Normal/Visual | Stage hunk |
| `<Space>hr` | Normal/Visual | Reset hunk |
| `<Space>hb` | Normal | Blame line detail |
| `]c` / `[c` | Normal | Jump to next / previous git hunk |

### 🩺 Diagnostics & Trouble (`<Space>x...`)

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>xx` | Normal | Toggle **Trouble** diagnostics list drawer |
| `<Space>xX` | Normal | Toggle buffer-local diagnostics |
| `<Space>xt` | Normal | Toggle TODOs drawer |
| `<Space>xQ` | Normal | Toggle Quickfix list |
| `<Space>d` | Normal | Show floating line diagnostic |
| `[d` / `]d` | Normal | Jump to previous / next diagnostic |

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

### 📑 Buffers & Window Management

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>e` | Normal | Toggle **Neo-tree** file explorer |
| `<S-l>` / `]b` | Normal | Go to next buffer tab |
| `<S-h>` / `[b` | Normal | Go to previous buffer tab |
| `<Space>x` | Normal | Close current buffer (keeps window split intact) |
| `<Space>sv` / `<Space>sh` | Normal | Split window vertically / horizontally |
| `<Space>se` / `<Space>sx` | Normal | Equalize splits / close current split |
| `<C-h>` / `<C-j>` / `<C-k>` / `<C-l>` | Normal | Move across window splits |

### 🧠 LSP & Code Intelligence (`<Space>c...`)

| Shortcut | Mode | Description |
|---|---|---|
| `K` | Normal | Show hover documentation / type signature |
| `gd` / `gD` | Normal | Go to definition / declaration |
| `gi` / `gr` | Normal | Go to implementation / find references |
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
| `<C-space>` / `<BS>` | Normal/Visual | Expand / shrink Treesitter syntax selection |

### 🎛️ UI & Toggles (`<Space>u...`)

| Shortcut | Mode | Description |
|---|---|---|
| `<Space>uc` | Normal | Toggle terminal **Smear-Cursor** animation on / off |
| `<Space>uu` | Normal | Toggle **UndoTree** visual branch history |

---

## 🚀 How to Push Changes to GitHub

To push your latest configuration to this repository from your terminal:

```bash
cd ~/.config/nvim
git push origin main
```

*(If prompted, enter your GitHub username and Personal Access Token or configure your SSH key).*

---

<div align="center">
  <sub>Built with ❤️ for rapid terminal workflows by DDreamer01</sub>
</div>
