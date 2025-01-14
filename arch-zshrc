export PATH=$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

plugins=(git sudo z fzf autojump command-not-found cp copypath copyfile history-substring-search zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias s="sudo"
alias sn="sudo shutdown now"
alias rb="sudo reboot"
alias add="sudo pacman -S"
alias del="sudo pacman -R"
alias purge="sudo pacman -Rsc"
alias clean="sudo pacman -Sc ; sudo pacman -Rns  '$(pacman -Qtdq)'"
alias update="sudo pacman -Syy"
alias upgrade="sudo pacman -Syyuu"
alias list="sudo pacman -Qe"
alias find="sudo pacman -Ss"
alias yay="yay -S --noconfirm"
alias makepkg="makepkg --si --noconfirm"

fastfetch
setopt nonomatch

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /usr/share/nvm/init-nvm.sh

eval "$(rbenv init - zsh)"
