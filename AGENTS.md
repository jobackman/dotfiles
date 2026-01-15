# AGENTS.md - Coding Guidelines for Dotfiles Repository

This file contains coding guidelines and commands for agentic coding assistants working in this dotfiles repository.

## Repository Overview

This is a personal dotfiles repository containing cross-platform shell configurations (WSL2 Ubuntu & macOS). The repository includes shell configurations, git settings, and tmux configurations.

## Build/Lint/Test Commands

### Installation & Setup

```bash
./install.sh
```

Runs the installation script that creates symlinks from repository files to home directory, with automatic backup creation.

### Shell Script Validation

```bash
bash -n install.sh  # Syntax check install.sh
bash -n shell/bashrc  # Syntax check bashrc (may have issues due to interactive checks)
bash -n shell/zshrc  # Syntax check zshrc
```

### Git Operations

```bash
git status  # Check working directory status
git diff    # Show unstaged changes
git add . && git commit -m "message"  # Stage and commit changes
```

## Code Style Guidelines

### Shell Scripts (Bash/Zsh)

#### File Structure

- Start with shebang: `#!/bin/bash` or `#!/bin/zsh`
- Use `set -e` for strict error handling in scripts
- Define variables at the top when possible
- Group related functionality together
- End files with proper line breaks

#### Syntax Style

```bash
# Good: Clear variable naming and quoting
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup-$(date +%Y%m%d-%H%M%S)"

# Good: Use arrays for collections
declare -A FILES=(
    ["shell/bashrc"]="$HOME/.bashrc"
    ["shell/zshrc"]="$HOME/.zshrc"
)

# Good: Functions with clear naming
info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
```

#### Error Handling

- Use `set -e` to exit on any error
- Check command success before proceeding
- Provide meaningful error messages
- Use `|| return` for optional operations

#### Comments

```bash
# Section headers with clear descriptions
# Files to symlink (source -> target)

# Brief comments for complex logic
# Backup existing file if not already a symlink
```

### Aliases (shell/aliases)

#### Organization

- Group aliases by functionality (directories, git, etc.)
- Sort aliases alphabetically within sections
- Use clear, descriptive names
- Include comments for complex aliases

#### Naming Conventions

```bash
# Good: Descriptive and consistent
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'

# Good: Function-based aliases with proper completion
function gccd() {
    # Function implementation
}
compdef _git gccd=git-clone
```

#### Git Aliases

- Follow oh-my-zsh git plugin conventions
- Use consistent abbreviations (g = git, ga = git add, etc.)
- Group by functionality (add, commit, branch, etc.)
- Include version checks for newer features

### Configuration Files

#### Git Config (git/gitconfig)

```ini
[user]
    name = Johan Bäckman
    email = johan.c.backman@gmail.com
[core]
    excludesfile = ~/.gitignore_global
    editor = code --wait
```

- Use standard git config format
- Group related settings
- Include comments for machine-specific overrides
- Use includes for local configurations

#### Tmux Config (tmux/tmux.conf)

```tmux
# Keybinds and other
set -g prefix C-s # Set prefix to Ctrl-a
set -g mouse on # Enable mouse support

# Plugins
set -g @plugin 'tmux-plugins/tpm'
```

- Group settings by functionality
- Include comments for non-obvious settings
- Use consistent plugin naming conventions
- Keep plugin initialization at the bottom

### General Guidelines

#### Naming Conventions

- Use lowercase with underscores for variables: `backup_dir`
- Use UPPERCASE for constants: `DOTFILES_DIR`
- Use descriptive function names: `git_main_branch()`
- Use consistent alias prefixes: `g` for git, no prefix for general

#### Formatting

- Use 4 spaces for indentation in shell scripts
- Align similar elements for readability
- Break long lines appropriately (80-100 characters)
- Use blank lines to separate logical sections

#### Imports and Dependencies

- Source external files explicitly: `. "$HOME/.cargo/env"`
- Check for file existence before sourcing: `[ -f ~/.fzf.bash ] && source ~/.fzf.bash`
- Use conditional loading for platform-specific features

#### Security Considerations

- Never commit sensitive files (.ssh/, .aws/, .env)
- Use includes for machine-specific credentials
- Exclude sensitive files from version control
- Document security exclusions in README

#### Error Handling Patterns

```bash
# Check command availability
if command -v xclip &> /dev/null; then
    alias pbcopy='xclip -selection clipboard'
fi

# Handle missing dependencies gracefully
command git rev-parse --git-dir &>/dev/null || return
```

#### Testing Approach

- Manual testing of installation script
- Verify symlinks are created correctly
- Test shell configurations load without errors
- Check git/tmux configurations work as expected
- Validate cross-platform compatibility (WSL2/macOS)

#### Commit Message Style

- Use imperative mood: "Add bash alias for directory navigation"
- Keep messages concise but descriptive
- Include context for configuration changes
- Reference affected components: "Update tmux config for Catppuccin theme"

#### Documentation

- Update README.md for structural changes
- Document new aliases and their purposes
- Include platform-specific notes
- Maintain installation and maintenance instructions

## Development Workflow

1. Edit files directly in the repository
2. Test changes locally
3. Run `./install.sh` to apply changes
4. Commit and push updates
5. Pull changes on other machines and re-run install script

## Platform Support

- ✅ WSL2 Ubuntu
- ✅ macOS
- ✅ Linux

## File Organization

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
