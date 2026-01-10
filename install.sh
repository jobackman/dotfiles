#!/bin/bash

# Simple dotfiles installer
# Usage: ./install.sh

set -e

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }

# Create backup directory
mkdir -p "$BACKUP_DIR"
info "Backup directory: $BACKUP_DIR"

# Files to symlink (source -> target)
declare -A FILES=(
    ["shell/bashrc"]="$HOME/.bashrc"
    ["shell/zshrc"]="$HOME/.zshrc"
    ["shell/aliases"]="$HOME/.aliases"
    ["git/gitconfig"]="$HOME/.gitconfig"
    ["tmux/tmux.conf"]="$HOME/.tmux.conf"
    # Add more as needed
)

for source in "${!FILES[@]}"; do
    target="${FILES[$source]}"
    source_path="$DOTFILES_DIR/$source"
    
    # Backup existing file if not already a symlink
    if [[ -f "$target" && ! -L "$target" ]]; then
        warn "Backing up $target"
        cp "$target" "$BACKUP_DIR/"
    fi
    
    # Create symlink
    info "Linking $source_path -> $target"
    ln -sf "$source_path" "$target"
done

info "Installation complete! Restart your shell or run 'source ~/.bashrc'"