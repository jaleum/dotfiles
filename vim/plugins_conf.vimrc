" gitgutter doesn't play nice with solarized, this should fix colors
highlight clear SignColumn
call gitgutter#highlight#define_highlights()
set updatetime=100  " allow for faster git updates
set signcolumn=yes  " always disply sign column

" autopairs
let g:AutoPairsCenterLine = 0  " disable jumping to center of screen when adding pair
let g:AutoPairsMapBS = 0  " disable deleting bracket pairs

