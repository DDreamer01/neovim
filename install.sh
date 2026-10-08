#!/usr/bin/env bash
# ==============================================================================
#  Neovim Automated Setup & Replication Script
#  Installs Neovim (>=0.10), CLI utilities, and syncs all plugins & LSPs.
# ==============================================================================
set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

info()  { echo -e "${BLUE}==>${NC} ${GREEN}$1${NC}"; }
warn()  { echo -e "${YELLOW}Warning:${NC} $1"; }
error() { echo -e "${RED}Error:${NC} $1"; exit 1; }

info "Detecting Operating System..."
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
  Linux)
    if [ -f /etc/os-release ]; then
      . /etc/os-release
      DISTRO=$ID
    fi
    ;;
  Darwin)
    DISTRO="macos"
    ;;
  *)
    error "Unsupported operating system: $OS"
    ;;
esac

info "Installing dependencies for $DISTRO ($ARCH)..."
if [ "$DISTRO" = "ubuntu" ] || [ "$DISTRO" = "debian" ]; then
  if command -v sudo >/dev/null 2>&1; then SUDO="sudo"; else SUDO=""; fi
  $SUDO apt-get update -qq
  $SUDO apt-get install -y -qq git curl tar gzip unzip ripgrep fd-find build-essential
  if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
    $SUDO ln -sf "$(which fdfind)" /usr/local/bin/fd || true
  fi
elif [ "$DISTRO" = "arch" ] || [ "$DISTRO" = "manjaro" ]; then
  sudo pacman -Syu --noconfirm git curl tar gzip unzip ripgrep fd base-devel neovim
elif [ "$DISTRO" = "fedora" ]; then
  sudo dnf install -y git curl tar gzip unzip ripgrep fd-find gcc gcc-c++ make neovim
elif [ "$DISTRO" = "macos" ]; then
  if ! command -v brew >/dev/null 2>&1; then
    error "Homebrew not found. Please install Homebrew first: https://brew.sh"
  fi
  brew install neovim ripgrep fd git
fi

# Ensure modern Neovim (>= 0.10) is installed on Linux
if [ "$OS" = "Linux" ]; then
  NVIM_VER="$(nvim --version 2>/dev/null | head -n 1 | grep -oE 'v[0-9]+\.[0-9]+' || echo 'none')"
  if [ "$NVIM_VER" = "none" ] || [ "$(echo -e "$NVIM_VER\nv0.10" | sort -V | head -n 1)" != "v0.10" ]; then
    info "Installing latest stable Neovim from GitHub releases..."
    ARCH_NAME="x86_64"
    if [ "$ARCH" = "aarch64" ] || [ "$ARCH" = "arm64" ]; then
      ARCH_NAME="arm64"
    fi
    NVIM_TAR_URL="https://github.com/neovim/neovim/releases/download/v0.12.5/nvim-linux-${ARCH_NAME}.tar.gz"
    TEMP_TAR="/tmp/nvim-linux-${ARCH_NAME}.tar.gz"
    curl -sLo "$TEMP_TAR" "$NVIM_TAR_URL"
    if command -v sudo >/dev/null 2>&1; then SUDO="sudo"; else SUDO=""; fi
    $SUDO mkdir -p /opt
    $SUDO tar -C /opt -xzf "$TEMP_TAR"
    $SUDO ln -sf "/opt/nvim-linux-${ARCH_NAME}/bin/nvim" /usr/local/bin/nvim
    rm -f "$TEMP_TAR"
  fi
fi

info "Verifying Neovim version..."
nvim --version | head -n 2

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
if [ ! -f "$CONFIG_DIR/init.lua" ]; then
  info "Linking or initializing config at $CONFIG_DIR..."
  SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  if [ "$SCRIPT_DIR" != "$CONFIG_DIR" ]; then
    mkdir -p "$(dirname "$CONFIG_DIR")"
    ln -sfn "$SCRIPT_DIR" "$CONFIG_DIR"
  fi
fi

info "Pre-warming lazy.nvim plugins..."
nvim --headless "+Lazy! sync" +qa

info "Pre-warming Treesitter parsers..."
nvim --headless "+TSInstallSync! bash python go gomod gowork gosum lua vim vimdoc json yaml toml markdown markdown_inline" +qa || true

info "Pre-warming Mason LSPs and tools..."
nvim --headless "+MasonInstall bash-language-server pyright gopls lua-language-server shellcheck shfmt ruff stylua" "+sleep 12" +qa || true

echo ""
echo -e "${GREEN}==============================================================================${NC}"
echo -e "${GREEN}  Neovim setup completed successfully!${NC}"
echo -e "${GREEN}  Run 'nvim' in your terminal to start coding.${NC}"
echo -e "${GREEN}  Press <Space> to explore keybindings with Which-Key.${NC}"
echo -e "${GREEN}==============================================================================${NC}"
