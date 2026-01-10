# Dotfiles Repository Plan

## Overview
This repository contains my personal dotfiles for easy setup across machines. It uses a simple bash script to create symlinks from the repository to the home directory.

## Supported Platforms
- WSL2 Ubuntu (Linux)
- macOS

## Repository Structure
```
dotfiles/
├── install.sh          # Installation script
├── bashrc              # Shell configuration (links to ~/.bashrc)
├── zshrc               # Zsh configuration (links to ~/.zshrc)
├── tmux.conf           # Tmux configuration (links to ~/.tmux.conf)
├── gitconfig           # Git configuration (links to ~/.gitconfig)
├── aliases             # Shell aliases (links to ~/.aliases)
└── PLAN.md             # This plan document
```

## Files Included
- `.bashrc`: Bash shell configuration
- `.zshrc`: Zsh shell configuration  
- `.tmux.conf`: Tmux terminal multiplexer config
- `.gitconfig`: Git version control settings
- `.aliases`: Custom shell aliases

## Why This Structure
- **No Leading Dots**: Files stored without dots in repo to avoid git/filesystem issues
- **Simple Symlinking**: Bash script creates symlinks to home directory
- **Cross-Platform**: Works on both Linux and macOS
- **Backup Safety**: Automatically backs up existing files

## Installation Script (install.sh)
```bash
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
    ["bashrc"]="$HOME/.bashrc"
    ["zshrc"]="$HOME/.zshrc" 
    ["tmux.conf"]="$HOME/.tmux.conf"
    ["gitconfig"]="$HOME/.gitconfig"
    ["aliases"]="$HOME/.aliases"
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
```

## Setup Instructions

### On Current Machine (First Time)
1. Copy dotfiles from home directory to repo:
   ```bash
   cp ~/.bashrc bashrc
   cp ~/.zshrc zshrc
   cp ~/.tmux.conf tmux.conf
   cp ~/.gitconfig gitconfig
   cp ~/.aliases aliases
   ```

2. Make install script executable:
   ```bash
   chmod +x install.sh
   ```

3. Test installation:
   ```bash
   ./install.sh
   ```

4. Commit changes:
   ```bash
   git add .
   git commit -m "Initial dotfiles setup"
   ```

### On New Machines
1. Clone repository:
   ```bash
   git clone <repository-url> ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Run installer:
   ```bash
   ./install.sh
   ```

3. Restart shell or source config:
   ```bash
   source ~/.bashrc
   ```

## Maintenance
- Edit files in the repository
- Commit changes: `git add . && git commit -m "Update config"`
- Update machines: Pull latest and re-run `./install.sh`

## Safety Features
- **Backups**: Existing files are backed up to timestamped directory
- **Idempotent**: Script can be run multiple times safely
- **Non-Destructive**: Only creates symlinks, doesn't delete originals

## Customization
- Add more files to the `FILES` array in `install.sh`
- Modify file contents as needed
- Comment out unwanted files in the script

## Excluded Files
Sensitive files like `.ssh/`, `.aws/`, `.env` are intentionally excluded and should not be version controlled.</content>
<parameter name="filePath">PLAN.md