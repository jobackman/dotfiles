# AGENTS.md

Instructions for AI coding agents operating in this repository.

## Project Overview

Personal dotfiles repository for cross-platform shell environment setup (WSL2 Ubuntu and macOS). Contains configuration files for Zsh, Bash, Git, and Tmux, managed with [GNU Stow](https://www.gnu.org/software/stow/) and installed as symlinks. This is **not** a software project with compiled code, packages, or a test suite -- it is a collection of shell configuration files.

## Repository Structure

```
dotfiles/
├── install.sh              # Stow wrapper script
├── shell/                  # Stow package: shell configs
│   ├── .zshrc              # Primary shell config (Zsh + oh-my-zsh framework)
│   ├── .bashrc             # Bash config (mostly Ubuntu defaults)
│   └── .aliases            # Shell aliases (ported from oh-my-zsh git plugin)
├── git/                    # Stow package: git configs
│   ├── .gitconfig          # Global git config (delta pager, VS Code editor)
│   ├── .stow-local-ignore  # Tells Stow to skip gitconfig.local
│   └── gitconfig.local     # Machine-specific git settings (not stowed)
└── tmux/                   # Stow package: tmux configs
    └── .tmux.conf          # Tmux config (Catppuccin mocha theme, TPM plugins)
```

Each subdirectory is a GNU Stow "package". Files inside mirror the target layout relative to `$HOME`. Running `stow shell` creates symlinks like `~/.zshrc -> dotfiles/shell/.zshrc`.

## Build / Lint / Test Commands

There is no build system, test suite, or CI/CD pipeline. The only executable is the installer.

### Installation

```bash
./install.sh
```

This runs `stow` for each package (`shell`, `git`, `tmux`), creating symlinks from the repo into `$HOME` (e.g., `shell/.zshrc` -> `~/.zshrc`). Stow will refuse to overwrite existing non-symlink files -- remove or back them up manually first.

Individual packages can also be stowed directly:

```bash
stow --target="$HOME" shell
```

### Validation

No automated validation exists. To manually check shell scripts for issues:

```bash
# Lint shell scripts with shellcheck (if installed)
shellcheck install.sh
shellcheck shell/.bashrc

# Verify symlinks are correctly set up
ls -la ~/.bashrc ~/.zshrc ~/.aliases ~/.gitconfig ~/.tmux.conf
```

### Adding New Dotfiles

1. Place the file in the appropriate category directory (`shell/`, `git/`, `tmux/`, or create a new one).
2. Name the file exactly as it should appear in `$HOME` (including the leading dot).
3. Add the new package name to the `PACKAGES` array in `install.sh` if it is a new category.
4. Run `./install.sh` or `stow --target="$HOME" <package>` to create the symlink.

## Code Style Guidelines

### Shell Scripts (Bash)

- **Shebang**: Always use `#!/bin/bash` for Bash scripts.
- **Fail-fast**: Use `set -e` at the top of executable scripts.
- **Variable quoting**: Always double-quote variables: `"$variable"`, `"$HOME/.config"`. Never leave variables unquoted.
- **Variable resolution**: Use `$(command)` for command substitution, not backticks. Exception: existing code in `zshrc` uses backticks for `fnm env` -- prefer `$(...)` in new code.
- **Functions**: Use the `function name() { ... }` syntax with explicit `function` keyword (matches existing alias file conventions).
- **Error handling**: Use `|| return` for non-fatal failures in functions. Use `2>/dev/null` or `&>/dev/null` to suppress expected errors.
- **Platform detection**: Check `$OSTYPE` for platform-specific code (`darwin*` for macOS, default for Linux/WSL).
- **Logging**: Use colored output functions (`info`, `warn`) with ANSI escape codes for user-facing scripts. Pattern:
  ```bash
  info() { echo -e "${GREEN}[INFO]${NC} $1"; }
  warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
  ```
- **Conditionals**: Use `[[ ... ]]` (double-bracket) for conditionals, not `[ ... ]`.
- **Path checks**: Use `command -v <cmd> &> /dev/null` to check if a command exists, not `which`.

### Shell Configuration Files (Zsh/Bash RC)

- **No file extensions**: Config files use dot-prefixed bare names (`.zshrc`, `.bashrc`, `.aliases`) -- no `.sh` or `.zsh` extensions. Files are named exactly as they appear in `$HOME` so GNU Stow can symlink them directly.
- **Section organization**: Use comment headers to separate logical sections:
  ```bash
  # --- Section Name ---
  ```
- **Aliases**: Define aliases with `alias name='command'`. For global aliases (Zsh-only), use `alias -g`.
- **Sourcing**: Use `source <file>` (not `.`) for consistency with existing code.
- **PATH modifications**: Append with `PATH=$PATH:/new/path` or prepend with `export PATH="/new/path:$PATH"`.
- **Conditional sourcing**: Guard optional sources with existence checks:
  ```bash
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  ```
  or:
  ```bash
  if [ -d "$SOME_PATH" ]; then
    export PATH="$SOME_PATH:$PATH"
  fi
  ```

### Git Configuration

- **Includes**: Machine-specific settings go in `gitconfig.local`, not in the main `gitconfig`. The main config uses `[include] path = ~/.gitconfig.local`.
- **Sensitive data**: Never commit credentials, SSH keys, API tokens, or `.env` files with secrets.

### Tmux Configuration

- **Inline comments**: Add explanatory comments on the same line as settings when the purpose isn't obvious.
- **Plugin management**: Use TPM (Tmux Plugin Manager). Keep `run '~/.tmux/plugins/tpm/tpm'` as the very last line.

### File and Directory Naming

- **Directories**: Lowercase, single-word names matching the tool category (`shell/`, `git/`, `tmux/`).
- **Files**: Lowercase. No extensions for shell config files. Use standard extensions where expected by tools (`.tmux.conf`, `install.sh`). Config files include the leading dot to match their `$HOME` target name.

### Git Commit Messages

Follow the existing style observed in the commit history:

- Short imperative sentences (e.g., "Add aliases from oh-my-zsh", "Fix history file, move statusbar top").
- No conventional-commits prefix (no `feat:`, `fix:`, etc.).
- No trailing period.
- Keep the first line under 72 characters.

## External Tool Dependencies

These tools are referenced in the configs but not managed by this repo:

| Tool | Purpose | Config location |
|------|---------|-----------------|
| oh-my-zsh | Zsh framework | `shell/.zshrc` |
| fnm | Node.js version manager | `shell/.zshrc` |
| Bun | JS runtime/package manager | `shell/.zshrc` |
| Homebrew | System package manager | `shell/.zshrc` |
| Starship | Cross-shell prompt | `shell/.zshrc` |
| zoxide | Smart `cd` replacement | `shell/.zshrc` |
| fzf | Fuzzy finder | `shell/.zshrc`, `shell/.bashrc` |
| delta | Git diff pager | `git/.gitconfig` |
| TPM | Tmux plugin manager | `tmux/.tmux.conf` |
| Catppuccin | Color theme (mocha) | `tmux/.tmux.conf` |

## Important Notes

- **Primary shell is Zsh**, not Bash. The `bashrc` is mostly the Ubuntu default kept as a fallback.
- **The aliases file is large** (~480 lines) and is largely ported from the oh-my-zsh git plugin. It uses Zsh-specific features (`compdef`, `setopt localoptions`, global aliases). Do not assume it is POSIX-compatible.
- **WSL2 is the primary environment**. Settings like `BROWSER=wslview` and the Windows credential manager path in `gitconfig.local` reflect this.
- **`install.sh` requires GNU Stow** to be installed. See the Installation section above.
- **No `.gitignore` exists** in this repo. Be careful not to add files containing secrets.
