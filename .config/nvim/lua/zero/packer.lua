local status, packer = pcall(require, 'packer')

if (not status) then
  print('Packer is not installed.')
  return
end

vim.cmd [[packadd packer.nvim]]

packer.startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Themes
  use({
    'rose-pine/neovim',
    as = 'rose-pine',
  })

  use({ "catppuccin/nvim", as = "catppuccin" })

  use {
    'svrana/neosolarized.nvim',
    requires = { 'tjdevries/colorbuddy.nvim' },
  }

  -- Plugins
  -- Status line
  use 'hoob3rt/lualine.nvim'

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }
  use('glepnir/lspsaga.nvim')

  -- nerdtree
  use({
    'nvim-tree/nvim-tree.lua',
    requires = { 'nvim-tree/nvim-web-devicons' },
  })

  -- comments
  use("terrortylor/nvim-comment")

  -- Copilot
  use("github/copilot.vim")

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use('nvim-telescope/telescope-file-browser.nvim')

  -- Treesitter
  use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
  use('nvim-treesitter/playground')
  -- use('mbbill/undotree')
  -- use('tpope/vim-fugitive')


  -- Zen mode
  use("folke/zen-mode.nvim")

  -- Auto close brackets
  use('windwp/nvim-autopairs')

  -- Auto close tags
  use('windwp/nvim-ts-autotag')

  -- Tabs
  use('akinsho/nvim-bufferline.lua')

  -- Colorizer
  use('norcalli/nvim-colorizer.lua')

  -- Git signs
  use('lewis6991/gitsigns.nvim')
  -- use("jose-elias-alvarez/null-ls.nvim")


end)

-- return packer
