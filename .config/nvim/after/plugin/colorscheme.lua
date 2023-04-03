neo = require('neosolarized').setup({
    comment_italics = true,
    background_set = false,
})
neo.Group.link('WarningMsg', neo.groups.Comment)

vim.cmd.colorscheme 'tokyonight'
vim.opt.background = 'dark'

