require('setup')

local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use ('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use 'mbbill/undotree'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-surround'
    use 'tpope/vim-commentary'
    use 'itchyny/lightline.vim'
    use 'lervag/vimtex'
    use 'theprimeagen/harpoon'
    use 'neovimhaskell/haskell-vim'
    use 'Pocco81/true-zen.nvim'
    use 'tpope/vim-repeat'
    use 'machakann/vim-highlightedyank'
    use 'norcalli/nvim-colorizer.lua'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/plenary.nvim'

    use {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end}

    use {
        'mrcjkb/haskell-tools.nvim',
        branch = '1.x.x', -- recommended
    }

    -- Themes
    use('ayu-theme/ayu-vim')
    use('RRethy/nvim-base16')
end)
