export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# History
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS

# Path
export PATH="$HOME/.local/bin:$PATH"

# Homebrew (optional if you still want it for other stuff)
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Oh My Posh ← this is the only line that changed
eval "$(oh-my-posh init zsh --config ~/.poshthemes/hul10.omp.json)"

# Carapace (you can just source it directly, no need for a function)
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense'
source <(carapace _carapace)

# Autosuggestions style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#888888"
