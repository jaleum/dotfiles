" vim plugins config

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

" TODO vim directory navigation
"Plug 'scrooloose/nerdtree'

" TODO fuzzy finder
" Plug 'junegunn/fzf'

" TODO code completer like coc? better syntax highlighting? linting ALE?
" folding?

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" helper commands to always update the plug snapshot
command InstallPlugins
  \ PlugInstall | PlugSnapshot! ~/.jward_vim/plug.snapshot

command UpdatePlugins
  \ PlugUpdate | PlugSnapshot! ~/.jward_vim/plug.snapshot

command CleanPlugins
  \ PlugClean | PlugSnapshot! ~/.jward_vim/plug.snapshot
