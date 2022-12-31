-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use('mbbill/undotree')
    use('tpope/vim-fugitive')
    use('tpope/vim-surround')
    use('tpope/vim-commentary')
    use('itchyny/lightline.vim')
    use('lervag/vimtex')
    use('theprimeagen/harpoon')
    use('neovimhaskell/haskell-vim')


    -- Themes
    use('ayu-theme/ayu-vim')
    use('https://gitlab.com/madyanov/gruber.vim')
    use('rakr/vim-one')
    use('Pocco81/true-zen.nvim')
    use('projekt0n/github-nvim-theme')
    use("catppuccin/nvim")

end)

