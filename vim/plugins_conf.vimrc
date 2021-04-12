" gitgutter doesn't play nice with solarized, this should fix colors
highlight clear SignColumn
call gitgutter#highlight#define_highlights()
set updatetime=100  " allow for faster git updates
