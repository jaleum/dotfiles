" general vimrc settings

" colors
syntax enable          " syntax highlighting
set background=light   " use the light colorscheme
colorscheme solarized  " set the vim colorscheme

" layout
set number             " show line numbers
set cursorline         " highlights the selected line
set title              " show file name in tab
set colorcolumn=100    " add a righthand column for seeing recommended file width

" editing
filetype plugin indent on  " indent based on the filetype, settings in ~/.vim/indent
set autoindent         " enable auto indent
set tabstop=2          " number of visual spaces per tab
set softtabstop=2      " number of spaces in tab when editing
set expandtab          " tabs converted to spaces
set shiftwidth=2       " auto indent between braces
set pastetoggle=<F2>   " toggle paste mode

" highlighting
set showmatch          " show matching brace
set hlsearch           " highlight all search words
set incsearch          " enable incremental search, showing matches as you type

" misc
set wildmenu           " visual autocompletee for command menu
set lazyredraw         " redraw only when needed, performance
