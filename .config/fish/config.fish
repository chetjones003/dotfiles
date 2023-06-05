### ADDING TO THE PATH
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin  $HOME/.local/bin $HOME/.config/emacs/bin $HOME/Applications /var/lib/flatpak/exports/bin/ $fish_user_paths

### EXPORT ###
set fish_greeting                                 # Supresses fish's intro message
set TERM "xterm-256color"                         # Sets the terminal type
set EDITOR "emacsclient -t -a ''"                 # $EDITOR use Emacs in terminal
set VISUAL "emacsclient -c -a emacs"              # $VISUAL use Emacs in GUI mode

### SET MANPAGER
### "nvim" as manpager
set -x MANPAGER "nvim -c 'set ft=man' -"

### SET EITHER DEFAULT EMACS MODE OR VI MODE ###
function fish_user_key_bindings
    bind \cy accept-autosuggestion

    fish_vi_key_bindings
end
### END OF VI MODE ###

# vim and emacs
alias vim='nvim'

alias nvimconf='cd $HOME/.config/nvim && nvim'
alias fishconf='cd $HOME/dotfiles/fish/.config/fish/ && nvim'
alias alacrittyconf='cd $HOME/dotfiles/alacritty/.config/alacritty/ && nvim'
alias starshipconf='cd $HOME/dotfiles/starship/.config/starship.toml'
alias dotfiles='cd $HOME/dotfiles'

# Changing "ls" to "exa"
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing
alias l.='exa -a | egrep "^\."'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

### SETTING THE STARSHIP PROMPT ###
starship init fish | source
