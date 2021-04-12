" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" colorscheme
Plug 'altercation/vim-colors-solarized'

" vim directory navigation
"Plug 'scrooloose/nerdtree'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()


syntax enable          " syntax highlighting
set background=light   " use the light colorscheme
colorscheme solarized  " set the vim colorscheme
set autoindent         " enable auto indent
set tabstop=2          " make tab 2 spaces
set shiftwidth=2       " auto indent between braces
set expandtab          " spaces instead of tabs
set number             " show line numbers
set showmatch          " show matching brace
set incsearch          " enable incremental search
set hlsearch           " highlight all search words
set title              " show file name in tab
set pastetoggle=<F2>   " toggle paste mode
set laststatus=2       " show file path
set ruler              " show row and column numbers
set cursorline         " highlights the selected line

" change leader to space
map <space> <leader>

" normal mappings 
" ===============
nnoremap <leader>nh :nohlsearch<CR>
nnoremap <leader>nn :set nonumber<CR>
nnoremap <leader>nm :set number<CR>

" insert mappings
" ===============
inoremap hjk <esc>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

