return require('packer').startup(function(use)
  -- Packer self-manage
  use 'wbthomason/packer.nvim'

  -- Colorscheme
  use { 'dracula/vim', as = 'dracula' }

  -- Status line
  use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }

  -- File browser
  use { 'kyazdani42/nvim-tree.lua', requires = { 'kyazdani42/nvim-web-devicons' } }

  -- Navigate between tmux panes
  use { "alexghergh/nvim-tmux-navigation" }

  -- LSP config, simplified
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

  -- Tree-sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }
  use { 'RRethy/nvim-treesitter-endwise' }
  use { 'windwp/nvim-ts-autotag' }

  -- Telescope and extensions
  use {
    'nvim-telescope/telescope.nvim', branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope-ui-select.nvim' }

  -- Auto-pairs
  use { 'windwp/nvim-autopairs' }

  -- Surround
  use { 'kylechui/nvim-surround' }

  -- Git stuff
  use { 'lewis6991/gitsigns.nvim' }

  -- Comments
  use { 'numToStr/Comment.nvim' }
end)
