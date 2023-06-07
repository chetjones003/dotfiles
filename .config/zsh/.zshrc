HISTFILE=$HOME/.config/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export PATH="$HOME/.local/bin":$PATH
export PATH=$HOME/.cargo/bin:$PATH
setopt HIST_IGNORE_SPACE
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"

plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "hlissner/zsh-autopair"
plug "zap-zsh/vim"
plug "zap-zsh/fzf"
plug "zap-zsh/completions"
plug "Aloxaf/fzf-tab"
plug "wintermi/zsh-rust"

# keybinds
bindkey '^y' autosuggest-accept

# Changing "ls" to "exa"
alias ls="exa -al --color=always --group-directories-first" # my preferred listing
alias la="exa -a --color=always --group-directories-first"  # all files and dirs
alias ll="exa -l --color=always --group-directories-first"  # long format
alias lt="exa -aT --color=always --group-directories-first" # tree listing
alias l.="exa -a | egrep '^\.'"

alias nvimconf='cd ~/.config/nvim && nvim'
alias zshconf='cd ~/dotfiles/.config/zsh/ && nvim .zshrc'
alias fishconf='cd ~/dotfiles/.config/fish/ && nvim config.fish'
alias alacrittyconf='cd ~/dotfiles/.config/alacritty/ && nvim alacritty.yml'
alias starshipconf='cd ~/dotfiles/.config/ && nvim starship.toml'
alias tmuxconf='cd ~/dotfiles/ && nvim .tmux.conf'
alias dotfiles='cd ~/dotfiles'

# helper for nmcli
alias wificonnect="echo 'nmcli device wifi list\nnmcli device rescan\nnmcli device connect <ssid> password <password>\nnmcli connection show'"

# helper for brightness
alias brightness="echo 'xrandr --output LVDS-1 --brightness <value>'"

# helper for audio
alias audio="echo 'amixer set Master <amount %>'"

eval "$(starship init zsh)"
