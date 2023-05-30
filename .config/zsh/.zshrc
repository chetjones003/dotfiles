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
bindkey '^ ' autosuggest-accept

# Changing "ls" to "exa"
alias ls="exa -al --color=always --group-directories-first" # my preferred listing
alias la="exa -a --color=always --group-directories-first"  # all files and dirs
alias ll="exa -l --color=always --group-directories-first"  # long format
alias lt="exa -aT --color=always --group-directories-first" # tree listing
alias l.="exa -a | egrep '^\.'"

alias nvimconf="cd $HOME/.config/nvim && nvim $HOME/.config/nvim"
alias zshconf="cd $HOME/.config/zsh && nvim $HOME/.config/zsh/.zshrc"
alias alaconf="cd $HOME/.config/alacritty && nvim $HOME/.config/alacritty/alacritty.yml"
alias tmuxconf="cd $HOME && nvim ~/.tmux.conf"
alias starconf="cd $HOME/.config && nvim $HOME/.config/starship.toml"

alias dotfiles="/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME"

eval "$(starship init zsh)"
