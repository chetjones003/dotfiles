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
let g:which_key_map['r'] = [ ':RnvimrToggle' , 'ranger' ]
let g:which_key_map['/'] = [ ':Startify', 'Home Buffer' ]

let g:which_key_map.M = 'which_key_ignore'

map <C-n> :CocCommand explorer<CR>

" Buffers
let g:which_key_map.b = {
    \ 'name' : '+buffers',
    \ 'b' : [':Buffers' , 'list buffers'],
    \ 'd' : [':bd' , 'close buffer'],
    \ 'n' : [':bn' , 'next buffer'],
    \ 'p' : [':bp' , 'previous buffer'],
    \ 'f' : [':bf' , 'first buffer'],
    \ 'l' : [':bl' , 'last buffer'],
    \ }

" Coc
let g:which_key_map.c = {
    \ 'name' : '+coc',
    \ }

" Git
let g:which_key_map.g = {
    \ 'name' : '+git',
    \ 's' : [':Magit' , 'status'],
    \ 'l' : [':Git log' , 'log'],
    \ 'h' : [':Git help' , 'help'],
    \ }

map <leader>gc :Git checkout <Space>
map <leader>gp :Git push <Space>

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

" Float term
let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ ';' : [':FloatermNew --wintype=popup --height=6'        , 'terminal'],
      \ 'f' : [':FloatermNew fzf'                               , 'fzf'],
      \ 'g' : [':FloatermNew lazygit'                           , 'git'],
      \ 'd' : [':FloatermNew lazydocker'                        , 'docker'],
      \ 'n' : [':FloatermNew node'                              , 'node'],
      \ 'N' : [':FloatermNew nnn'                               , 'nnn'],
      \ 'p' : [':FloatermNew python'                            , 'python'],
      \ 'r' : [':FloatermNew ranger'                            , 'ranger'],
      \ 't' : [':FloatermToggle'                                , 'toggle'],
      \ 'y' : [':FloatermNew ytop'                              , 'ytop'],
      \ 's' : [':FloatermNew ncdu'                              , 'ncdu'],
      \ }

" Quit
let g:which_key_map.q = {
    \ 'name' : '+quit',
    \ 'q' : [':q' , 'quit'],
    \ }

autocmd! User vim-which-key call which_key#register('<Space>', 'g:which_key_map')
