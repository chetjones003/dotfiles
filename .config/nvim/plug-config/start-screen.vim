let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

let g:startify_bookmarks = [
            \ { 'c': '~/.config/alacritty/alacritty.yml' },
            \ { 'i': '~/.config/nvim/init.vim' },
            \ { 'z': '~/.config/fish/config.fish' },
            \ '~/Documents/Pygame',
            \ '~/Documents',
            \ ]

let g:startify_session_autoload = 1
let g:startify_fortune_use_unicode = 1
