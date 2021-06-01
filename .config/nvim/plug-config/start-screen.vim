" Session dir
let g:startify_session_dir = '~/.config/nvim/session'

" Menu setup
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

" Bookmark setup
let g:startify_bookmarks = [
            \ { 'c': '~/.config/nvim/init.vim' },
            \ { 'f': '~/.config/fish/config.fish' },
            \ ]

" automatically restart a session
" If this option is enabled and you start Vim in a directory that contains a Session.vim 
" that session will be loaded automatically. Otherwise it will be shown as the top entry in the Startify buffer.
let g:startify_session_autoload = 1

" Let Startify take care of buffers
let g:startify_session_delete_buffers = 1

" Similar to Vim-rooter
let g:startify_change_to_vcs_root = 1

" Unicode
let g:startify_fortune_use_unicode = 1

" Automatically Update Sessions
let g:startify_session_persistence = 1

" Get rid of empy buffer and quit
let g:startify_enable_special = 0

" Custom Header
let g:startify_custom_header = [
\ '       _______.___________. _______  __       __          ___      .______       ',
\ '      /       |           ||   ____||  |     |  |        /   \     |   _  \      ', 
\ '     |   (----`---|  |----`|  |__   |  |     |  |       /  ^  \    |  |_)  |     ', 
\ '      \   \       |  |     |   __|  |  |     |  |      /  /_\  \   |      /      ', 
\ '  .----)   |      |  |     |  |____ |  `----.|  `----./  _____  \  |  |\  \----. ',
\ '  |_______/       |__|     |_______||_______||_______/__/     \__\ | _| `._____| ',
\ '                                                                                 ',
\ '                            ____    ____  __  .___  ___.                         ',
\ '                            \   \  /   / |  | |   \/   |                         ',
\ '                             \   \/   /  |  | |  \  /  |                         ',
\ '                              \      /   |  | |  |\/|  |                         ',
\ '                               \    /    |  | |  |  |  |                         ',
\ '                                \__/     |__| |__|  |__|                         ',
\]
