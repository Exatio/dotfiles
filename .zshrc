# -----------------------------------------------------
# PFetch
# -----------------------------------------------------
pfetch


# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=( 
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------
# For some reason the defaults doesnt work for me
# -----------------------------------------------------
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

# -----------------------------------------------------
# PYWAL
# -----------------------------------------------------
cat ~/.cache/wal/sequences &


# -----------------------------------------------------
# Aliases
# -----------------------------------------------------
alias c='clear && pfetch'
alias pf='pfetch'
alias ls='eza -la'
alias cat='bat'
alias shutdown='systemctl poweroff'
alias cleanup='~/dotfiles/scripts/cleanup.sh'
alias ts='~/dotfiles/scripts/snapshot.sh'
alias fonts='~/dotfiles/scripts/snapshot.sh'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
