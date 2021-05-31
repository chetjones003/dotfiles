" Map leader to which_key
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
set timeoutlen=100

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler

" Single mappings
let g:which_key_map['r'] = [ ':RnvimrToggle'                    , 'ranger' ]

" Buffers
let g:which_key_map.b = {
    \ 'name' : '+buffers',
    \ 'b' : [':Buffers' , 'list buffers'],
    \ 'd' : [':bd' , 'close buffer'],
    \ 'n' : [':bn' , 'next buffer'],
    \ 'p' : [':bp' , 'previous buffer'],
    \ }

" Coc
let g:which_key_map.c = {
    \ 'name' : '+coc',
    \ 'e' : [':CocCommand explorer' , 'explorer'],
    \ }

" Window keys
let g:which_key_map.w = {
    \ 'name' : '+window',
    \ 'b' : ['<C-W>s' , 'split below'],
    \ 'r' : ['<C-W>v' , 'split right'],
    \ 'c' : ['<C-W>c' , 'close window'],
    \ 'h' : ['<C-W>h' , 'move right'],
    \ 'j' : ['<C-W>j' , 'move down'],
    \ 'k' : ['<C-W>k' , 'move up'],
    \ 'l' : ['<C-W>l' , 'move left'],
    \ }

" Bracey keys
let g:which_key_map.a = {
    \ 'name' : '+bracey',
    \ 's' : [':Bracey' , 'start server'],
    \ 'r' : [':BraceyReload' , 'reload server'],
    \ 'q' : [':BraceyQuit' , 'quit server'],
    \ }

" File keys
let g:which_key_map.f = {
    \ 'name' : '+file',
    \ 's' : [':w' , 'save file'],
    \ 'f' : [':Files' , 'find file'],
    \ 'r' : [':Rg' , 'ripgrep'],
    \ 'c' : {
      \ 'name' : '+configs',
      \ 'v' : {
        \ 'name' : '+vim',
          \ 'k' : [':e ~/.config/nvim/keys/which-key.vim' , 'which-key.vim'],
          \ 'c' : [':e ~/.config/nvim/coc-settings.json' , 'coc-settings.json'],
          \ 'n' : [':e ~/.config/nvim/plug-config/coc.vim' , 'coc.vim'],
          \ 'p' : [':e ~/.config/nvim/plug-config/plugins.vim' , 'plugins.vim'],
          \ },
      \ 'f' : [':e ~/.config/fish/config.fish' , 'fish config'],
      \ 'a' : [':e ~/.config/alacritty/alacritty.yml' , 'alacritty config'],
      \ },
    \ }

" Quit
let g:which_key_map.q = {
    \ 'name' : '+quit',
    \ 'q' : [':q' , 'quit'],
    \ }

autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
