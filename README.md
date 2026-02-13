# Dotfiles

Personal dotfiles for cross-platform environment setup (WSL2 Ubuntu & macOS).

Managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Structure

```
dotfiles/
├── install.sh              # Stow wrapper script
├── shell/                  # Shell configurations (stow package)
│   ├── .bashrc             # Bash configuration
│   ├── .zshrc              # Zsh configuration
│   └── .aliases            # Shell aliases
├── git/                    # Git configurations (stow package)
│   ├── .gitconfig          # Git config
│   └── gitconfig.local     # Machine-specific git settings (not stowed)
└── tmux/                   # Tmux configurations (stow package)
    └── .tmux.conf          # Tmux config
```

Each subdirectory is a Stow "package". Files inside mirror the structure
of `$HOME` -- running `stow shell` creates `~/.bashrc`, `~/.zshrc`, and
`~/.aliases` as symlinks back into this repo.

## Prerequisites

- [GNU Stow](https://www.gnu.org/software/stow/)
  ```bash
  # Ubuntu/Debian
  sudo apt install stow

  # macOS
  brew install stow
  ```

## Installation

### First Time Setup

1. Clone this repository:
   ```bash
   git clone <repository-url> ~/git/dotfiles
   cd ~/git/dotfiles
   ```

2. Run the installation script (stows all packages):
   ```bash
   ./install.sh
   ```

   Or stow packages individually:
   ```bash
   stow --target="$HOME" shell
   stow --target="$HOME" git
   stow --target="$HOME" tmux
   ```

3. Restart your shell or source your configuration:
   ```bash
   source ~/.bashrc  # or ~/.zshrc
   ```

### Uninstalling

Remove symlinks for all packages:
```bash
stow -D --target="$HOME" shell git tmux
```

## Safety

- **Conflict detection**: Stow will refuse to overwrite existing files that are not symlinks it manages. Back up or remove conflicting files first.
- **Idempotent**: Safe to run multiple times.
- **Non-destructive**: Only creates symlinks, never deletes your files.

## Maintenance

1. Edit files directly in the repository -- changes take effect immediately since they are symlinked:
   ```bash
   cd ~/git/dotfiles
   vim shell/.bashrc
   ```

2. Commit your changes:
   ```bash
   git add .
   git commit -m "Update bashrc"
   git push
   ```

3. On other machines, pull and re-stow:
   ```bash
   cd ~/git/dotfiles
   git pull
   ./install.sh
   ```

## Adding New Dotfiles

1. Place the file in the appropriate package directory with the target name (including the leading dot):
   ```bash
   # Example: add a new .vimrc managed by a "vim" package
   mkdir -p vim
   cp ~/.vimrc vim/.vimrc
   ```

2. Stow the package:
   ```bash
   stow --target="$HOME" vim
   ```

   Or add it to the `PACKAGES` array in `install.sh` for automatic stowing.

## Platform Support

- WSL2 Ubuntu
- macOS
- Linux

## Excluded Files

Sensitive files are intentionally excluded:
- `.ssh/` - SSH keys
- `.aws/` - AWS credentials
- `.env` - Environment variables with secrets
- History files
