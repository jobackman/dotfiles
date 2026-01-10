# Dotfiles

Personal dotfiles for cross-platform environment setup (WSL2 Ubuntu & macOS).

## Structure

```
dotfiles/
├── install.sh          # Installation script
├── shell/              # Shell configurations
│   ├── bashrc         # Bash configuration
│   ├── zshrc          # Zsh configuration
│   └── aliases        # Shell aliases
├── git/               # Git configurations
│   └── gitconfig      # Git config
└── tmux/              # Tmux configurations
    └── tmux.conf      # Tmux config
```

## Installation

### First Time Setup

1. Clone this repository:
   ```bash
   git clone <repository-url> ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Run the installation script:
   ```bash
   ./install.sh
   ```

3. Restart your shell or source your configuration:
   ```bash
   source ~/.bashrc  # or ~/.zshrc
   ```

### What It Does

The `install.sh` script will:
- Create timestamped backups of existing dotfiles
- Create symlinks from repository files to your home directory
- Provide colored output showing what's happening

## Safety

- **Automatic Backups**: Existing files are backed up to `~/.dotfiles-backup-YYYYMMDD-HHMMSS/`
- **Idempotent**: Safe to run multiple times
- **Non-Destructive**: Only creates symlinks, doesn't delete originals

## Maintenance

1. Edit files directly in the repository:
   ```bash
   cd ~/.dotfiles
   vim shell/bashrc
   ```

2. Commit your changes:
   ```bash
   git add .
   git commit -m "Update bashrc"
   git push
   ```

3. On other machines, pull and re-run:
   ```bash
   cd ~/.dotfiles
   git pull
   ./install.sh
   ```

## Adding New Dotfiles

1. Copy the file to the appropriate directory (e.g., `shell/`, `git/`, etc.)
2. Add entry to the `FILES` array in `install.sh`:
   ```bash
   ["category/filename"]="$HOME/.filename"
   ```
3. Run `./install.sh` to create the symlink

## Platform Support

- ✅ WSL2 Ubuntu
- ✅ macOS
- ✅ Linux

## Excluded Files

Sensitive files are intentionally excluded:
- `.ssh/` - SSH keys
- `.aws/` - AWS credentials
- `.env` - Environment variables with secrets
- History files
