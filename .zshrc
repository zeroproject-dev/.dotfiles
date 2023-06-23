# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/.cargo/bin:$PATH"

if [[ $(uname -a | grep ARCH | wc -l) -eq 1 ]]; then
  source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
  plugins=(
    zsh-autosuggestions
  )
  alias vim="nvim"
  alias vi="nvim"
else
  source ~/powerlevel10k/powerlevel10k.zsh-theme
  alias nvim='/home/zero/downloads/nvim-linux64/bin/nvim'
  . "$HOME/.cargo/env"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
alias ls="lsd"
alias cat="bat"
alias catn="/bin/cat"

eval "$(fnm env --use-on-cd)"
