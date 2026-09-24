export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

typeset -U path
path=("$HOME/.local/bin" $path)

[[ -r "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

source "$ZSH/oh-my-zsh.sh"
