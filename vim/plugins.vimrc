" vim plugins config

" Download plug.vim if it doesn't exist yet
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" colorscheme
Plug 'altercation/vim-colors-solarized'

" show git changes in left column
Plug 'airblade/vim-gitgutter'

" clean status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" gcc/gc for commenting out code
Plug 'tpope/vim-commentary'

" match indentation of current file
Plug 'tpope/vim-sleuth'

" automatically add pair for braces/brackets
Plug 'jiangmiao/auto-pairs'

" vim directory navigation
Plug 'preservim/nerdtree'

" fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" TODO code completer like coc? better syntax highlighting? linting ALE?
" folding?

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

