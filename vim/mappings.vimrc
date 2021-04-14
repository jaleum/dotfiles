" change leader to space
map <space> <leader>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Normal mappings (nore means non-recursive)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>w :w<cr>
nnoremap <leader>nh :nohlsearch<CR>
nnoremap <leader>nn :set nonumber<CR>
nnoremap <leader>nm :set number<CR>

" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" edit vimrc
nnoremap <leader>vv :vs ~/.jward_vim<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

" plugin management
nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>pu :PlugUpdate<cr>
nnoremap <leader>pc :PlugClean<cr>
nnoremap <leader>ps :PlugSnapshot! ~/.jward_vim/plug.snapshot<cr>

" strip all trailing whitespace
nnoremap <leader>sw :%s/\s\+$//e<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Insert mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
inoremap hjk <esc>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" iterm sends hex code 0x4 (or ctrl-d) when fn-Del (forward delete) is pressed
" map this to the vim forward delete
inoremap <C-d> <Del>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" copy to system clipboard
vnoremap <leader>c "*y