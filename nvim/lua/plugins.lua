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
  use 'wbthomason/packer.nvim'
  use 'navarasu/onedark.nvim'
  use {
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }   
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use {"akinsho/toggleterm.nvim", tag = '*'}
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  if packer_bootstrap then
    require('packer').sync()
  end

  -- Setup
  require("nvim-tree").setup()
  require("lualine").setup()
  require("toggleterm").setup()
end)
