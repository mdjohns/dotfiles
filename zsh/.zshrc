HISTFILE=~/.histfile
HISTSIZE=50000
SAVEHIST=10000

bindkey -v

zstyle :compinstall filename '/home/dylan/.zshrc'
autoload -Uz compinit
compinit

source ~/.aliases

export EDITOR=nvim

source <(fzf --zsh)

# Starship shell
eval "$(starship init zsh)"

# Zoxide (better cd)
eval "$(zoxide init zsh)"
