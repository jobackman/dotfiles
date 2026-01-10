# --- Oh My Zsh ---

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  # z
  git
  aliases
  # zsh-autosuggestions
  # starship
)

source $ZSH/oh-my-zsh.sh


# --- User configuration ---

export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt autocd
autoload -U compinit; compinit

# alias
source ~/.aliases
# load environment variables
source ~/.env.keys

PATH=$PATH:/home/johan/.local/bin
PATH=$PATH:./node_modules/.bin

# bun completions
[ -s "/home/johan/.bun/_bun" ] && source "/home/johan/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# wsl utilities
export BROWSER=wslview

# fnm
FNM_PATH="/home/johan/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/johan/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi

eval "$(fnm env --use-on-cd --shell zsh)"

# opencode
export PATH=/home/johan/.opencode/bin:$PATH

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ctrl+r fzf
source <(fzf --zsh)

# Starship
eval "$(starship init zsh)"

# zoxide
eval "$(zoxide init zsh)"
