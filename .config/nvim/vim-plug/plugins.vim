" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

    Plug 'sheerun/vim-polyglot'
    Plug 'preservim/nerdtree'
    Plug 'vhdirk/vim-cmake'
    Plug 'antoinemadec/FixCursorHold.nvim'
    Plug 'scrooloose/NERDTree'
    Plug 'jiangmiao/auto-pairs'
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    "Plug 'joshdick/onedark.vim'
    Plug 'morhetz/gruvbox'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'unblevable/quick-scope'
    Plug 'justinmk/vim-sneak'
    Plug 'liuchengxu/vim-which-key'
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'airblade/vim-rooter'
    Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'junegunn/gv.vim'
    Plug 'voldikss/vim-floaterm'
    Plug 'mhinz/vim-startify'
    Plug 'honza/vim-snippets'
    Plug 'habamax/vim-godot'

call plug#end()

