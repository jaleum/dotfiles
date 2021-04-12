" general vimrc settings

" colors
syntax enable          " syntax highlighting
set background=light   " use the light colorscheme
colorscheme solarized  " set the vim colorscheme

" layout
set number             " show line numbers
set ruler              " show row and column numbers
set cursorline         " highlights the selected line
set laststatus=2       " show file path
set title              " show file name in tab


" editing
set autoindent         " enable auto indent
set tabstop=2          " make tab 2 spaces
set shiftwidth=2       " auto indent between braces
set expandtab          " spaces instead of tabs
set pastetoggle=<F2>   " toggle paste mode

" highlighting
set showmatch          " show matching brace
set hlsearch           " highlight all search words
set incsearch          " enable incremental search, showing matches as you type
