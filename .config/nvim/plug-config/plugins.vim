call plug#begin('~/.vim/plugged')
  Plug 'voldikss/vim-floaterm'
  Plug 'mhinz/vim-startify'
  Plug 'justinmk/vim-sneak'
  Plug 'mhinz/vim-signify'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  Plug 'gmarik/Vundle.vim'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'suan/vim-instant-markdown', {'rtp': 'after'}
  Plug 'frazrepo/vim-rainbow'
  Plug 'ryanoasis/vim-devicons'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-rooter'
  Plug 'kevinhwang91/rnvimr', {'do': 'make sync'}
  Plug 'mattn/emmet-vim'
  Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
  Plug 'turbio/bracey.vim'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'jreybert/vimagit'
  Plug 'ap/vim-css-color'
  Plug 'junegunn/vim-emoji'
call plug#end()

