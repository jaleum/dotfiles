" vim plugins config

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" colorscheme
Plug 'altercation/vim-colors-solarized'

" show git changes in left column
Plug 'airblade/vim-gitgutter'

" vim directory navigation
"Plug 'scrooloose/nerdtree'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
