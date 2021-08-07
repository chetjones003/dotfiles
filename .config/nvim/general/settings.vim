" set leader key
let g:mapleader = "\<Space>"

syntax enable                           " Enables syntax highlighing
set wildmenu                            " display all matches for search complete
set noswapfile                          " no swap file
set hidden                              " Required to keep multiple buffers open multiple buffers
set mouse=a                             " Enable your mouse
set t_Co=256                            " Support 256 colors
set expandtab                           " Converts tabs to spaces
set autoindent                          " Good auto indent
set laststatus=2                        " Always display the status line
set number                              " Line numbers
set background=dark                     " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set clipboard=unnamedplus               " Copy paste between vim and everything else

au! BufWritePost $MYVIMRC source %      " auto source when writing to init.vm alternatively you can run :source $MYVIMRC
