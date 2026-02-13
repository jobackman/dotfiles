# --- Oh My Zsh ---

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  # z
  # git
  # aliases
  # zsh-autosuggestions
  # starship
)

# source $ZSH/oh-my-zsh.sh

# --- User configuration ---

export HISTFILE=~/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt APPEND_HISTORY
setopt autocd
autoload -U compinit; compinit

# alias
source ~/.aliases

# load environment variables
source ~/.env.keys

PATH=$PATH:$HOME/.local/bin
PATH=$PATH:./node_modules/.bin

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# wsl utilities
export BROWSER=wslview

# fnm
FNM_PATH="$HOME/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

eval "$(fnm env --use-on-cd --shell zsh)"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ctrl+r fzf
source <(fzf --zsh)

# Starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"
