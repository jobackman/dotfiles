#!/bin/bash

# Dotfiles installer using GNU Stow
# Usage: ./install.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }

if ! command -v stow &>/dev/null; then
    echo -e "${RED}[ERROR]${NC} GNU Stow is not installed. Install it first:"
    echo "  Ubuntu/Debian: sudo apt install stow"
    echo "  macOS:         brew install stow"
    exit 1
fi

PACKAGES=(shell git tmux)

cd "$DOTFILES_DIR"

for pkg in "${PACKAGES[@]}"; do
    info "Stowing $pkg"
    stow -v --target="$HOME" "$pkg"
done

info "Installation complete!"
