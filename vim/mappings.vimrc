" change leader to space
map <space> <leader>

" Allow line by line scrolling with mouse
map <ScrollWheelUp> j
map <ScrollWheelDown> k

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
nnoremap <leader>vv :vs ~/.jacobw_vim<cr>
nnoremap <leader>sv :source ~/.vimrc<cr>

" plugin management
nnoremap <leader>pi :PlugInstall<cr>
nnoremap <leader>pu :PlugUpdate<cr>
nnoremap <leader>pc :PlugClean<cr>
nnoremap <leader>ps :PlugSnapshot! ~/.jacobw_vim/plug.snapshot<cr>

" strip all trailing whitespace
nnoremap <leader>sw :%s/\s\+$//e<cr>

" Start fzf
nnoremap <leader>f :Files<cr>

" search contents of files
nnoremap <leader>s :Rg<cr>

" toggle nerd tree
nnoremap <C-n> :NERDTreeToggle<cr>

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
vnoremap hjk <esc>
