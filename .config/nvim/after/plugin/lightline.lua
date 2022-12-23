vim.cmd(
[[
let g:lightline = {
            \ 'colorscheme': 'ayu',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'readonly', 'absolutepath', 'modified'] ]
            \ },
            \ }

]]
)
