local fn = vim.fn

-- Automatically install packer

-- uncomment below for MacOS/Linux
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

--uncomment below for Windows
--[[ local install_path = fn.stdpath('data') .. "\\site\\pack\\packer\\start\\packer.nvim" ]]

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)

  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use "windwp/nvim-autopairs" -- Autopairs, integrates with both cmp and treesitter
  use "kylechui/nvim-surround" -- Add/change/delete surrounding delimiter pairs with ease
  use 'NvChad/nvim-colorizer.lua' -- highlights color hexcodes with the hexcode color
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use 'JoosepAlviste/nvim-ts-context-commentstring' -- use TS context to correctly comment (eg. jsx)
  use "lewis6991/impatient.nvim" -- Speed up loading Lua modules
  use "lukas-reineke/indent-blankline.nvim" -- adds indentation guides
  use "goolord/alpha-nvim" -- adds dashboard on startup
  use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use "folke/which-key.nvim" -- displays a popup with possible key bindings

  -- colorschemes
  -- use "lunarvim/colorschemes"
  use "EdenEast/nightfox.nvim"
  use "catppuccin/nvim"
  use "marko-cerovac/material.nvim"
  use "shaeinst/roshnivim-cs"

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "ray-x/lsp_signature.nvim" -- shows signatures when using functions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-nvim-lua"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/mason.nvim" -- simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" -- bridges mason.nvim with the lspconfig plugin
  use "jose-elias-alvarez/null-ls.nvim" -- for formatters and linters
  use "folke/trouble.nvim" -- shows list for showing diagnostics, references, telescope results
  use "simrat39/rust-tools.nvim" -- includes more rust LSP helpers
  use 'mfussenegger/nvim-dap' -- for debugging rust-tools
  use "simrat39/symbols-outline.nvim" -- simple tree view for lsp symbols

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-project.nvim"
  use "BurntSushi/ripgrep"

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }
  use "nvim-treesitter/nvim-treesitter-context"
  use "p00f/nvim-ts-rainbow"

  -- Git
  use "lewis6991/gitsigns.nvim"

  -- Nvim Tree
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'

  -- Bufferline
  use "akinsho/bufferline.nvim"
  use "moll/vim-bbye"

  -- Lualine
  use 'nvim-lualine/lualine.nvim'

  -- Toggleterm
  use "akinsho/toggleterm.nvim"

  -- Markdown Previewer
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
