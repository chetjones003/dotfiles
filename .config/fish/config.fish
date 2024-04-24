set -e fish_user_paths
set -U fish_user_paths /usr/local/go/bin $HOME/.config/emacs/bin/ $HOME/.bin $HOME/.cargo/bin $HOME/.local/bin $HOME/.config/emacs/bin $HOME/Applications /var/lib/flatpak/exports/bin/ $fish_user_paths

### EXPORT ###
set fish_greeting         # Supresses fish's intro message
set TERM "xterm-256color" # Sets the terminal type
set EDITOR "nvim"         # $EDITOR use Emacs in terminal
set VISUAL "nvim"         # $VISUAL use Emacs in GUI mode

### SET MANPAGER
set -x MANPAGER "nvim +Man!"

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end
### END OF VI MODE ###

bind -M insert \cy accept-autosuggestion

# Onedark Color Palette
set -l foreground abb2bf
set -l selection 848b98
set -l comment 5c6370
set -l red e86671
set -l orange d19a66
set -l yellow e5c07b
set -l green 98c379
set -l purple c678dd
set -l cyan 56b6c2
set -l pink c678dd

# Syntax Highlighting Colors
set -g fish_color_normal $foreground
set -g fish_color_command $cyan
set -g fish_color_keyword $pink
set -g fish_color_quote $yellow
set -g fish_color_redirection $foreground
set -g fish_color_end $orange
set -g fish_color_error $red
set -g fish_color_param $purple
set -g fish_color_comment $comment
set -g fish_color_selection --background=$selection
set -g fish_color_search_match --background=$selection
set -g fish_color_operator $green
set -g fish_color_escape $pink
set -g fish_color_autosuggestion $comment

# Completion Pager Colors
set -g fish_pager_color_progress $comment
set -g fish_pager_color_prefix $cyan
set -g fish_pager_color_completion $foreground
set -g fish_pager_color_description $comment
set -g fish_pager_color_selected_background --background=$selection

### ALIASES ###
# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

# Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# ps
alias psa="ps auxf"
alias psgrep="ps aux | grep -v grep | grep -i -e VSZ -e"
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'

# switch between shells
# I do not recommend switching default SHELL from bash.
alias tobash="sudo chsh $USER -s /bin/bash && echo 'Now log out.'"
alias tozsh="sudo chsh $USER -s /bin/zsh && echo 'Now log out.'"
alias tofish="sudo chsh $USER -s /bin/fish && echo 'Now log out.'"

alias cb="cargo build"
alias cr="cargo run"
alias cc="cargo check"
alias ca="cargo add"
alias cn="cargo new"

# setup node and typescript with testing
function node-ts-test
    npm init -y
    npm i -D typescript ts-node jest ts-jest @types/node @types/jest
    tsc --init --sourceMap --rootDir src --outDir dist --target ES2020 --moduleResolution node
    npx ts-jest config:init
    npm init @eslint/config
end
alias npmProjGenWithTest=node-ts-test

starship init fish | source

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
