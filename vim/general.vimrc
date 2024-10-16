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
set noshowmode         " disable mode below status bar since airline is there
set wrap               " wraps text visually rather than editting text
set linebreak          " tries not to break in the middle of a word
set splitbelow         " new splits are on bottom rather than top
set splitright         " new vertical splits are on right rather than left

" editing
filetype plugin indent on  " indent based on the filetype, settings in ~/.vim/indent
set autoindent         " enable auto indent
set tabstop=2          " number of visual spaces per tab
set softtabstop=2      " number of spaces in tab when editing
set expandtab          " tabs converted to spaces
set shiftwidth=2       " auto indent between braces
set pastetoggle=<F2>   " toggle paste mode
set backspace=indent,eol,start  " fix backspacing behavior
set mouse=a            " Allow mouse scrolling in all modes

" highlighting
set showmatch          " show matching brace
set hlsearch           " highlight all search words
set incsearch          " enable incremental search, showing matches as you type

" misc
set wildmenu           " visual autocompletee for command menu
set lazyredraw         " redraw only when needed, performance
