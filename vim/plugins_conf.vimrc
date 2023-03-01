" gitgutter doesn't play nice with solarized, this should fix colors
highlight clear SignColumn
call gitgutter#highlight#define_highlights()
set updatetime=100  " allow for faster git updates
set signcolumn=yes  " always disply sign column

" autopairs
let g:AutoPairsCenterLine = 0  " disable jumping to center of screen when adding pair
let g:AutoPairsMapBS = 0  " disable deleting bracket pairs

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" fzf fills screen
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.9 } }

" use rg for searching in files, ignore file names
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
