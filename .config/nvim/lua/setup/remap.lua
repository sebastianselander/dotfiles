vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<space>", "<Nop>")
vim.keymap.set("n", "<esc>", vim.cmd.noh)
vim.keymap.set("n", "<leader>p", "\"_dP")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "Y", "yg$")

vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>p",  "\"_dP")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>p",  "\"_dP")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
