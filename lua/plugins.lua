local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
  execute 'packadd packer.nvim'
end

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(
    {
        function(use)
            -- Packer can manage itself as an optional plugin
            use 'wbthomason/packer.nvim'

            -- Neovim plugin that allows you to easily write your .vimrc in lua or any lua based language
            use 'svermeulen/vimpeccable'

            -- Clean, vibrant and pleasing color schemes for Vim, Sublime Text, iTerm, gnome-terminal and more. 
            use {'sonph/onehalf', rtp = 'vim', config = require('plugins._color').config }

            -- A snazzy bufferline for Neovim
            use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons', config = require('plugins._bufferline').config }

            -- A blazing fast and easy to configure neovim statusline written in pure lua.
            use {'hoob3rt/lualine.nvim', requires = 'kyazdani42/nvim-web-devicons', config = require('plugins._lualine').config }

            -- Find, Filter, Preview, Pick. All lua, all the time.
            use { 'nvim-telescope/telescope.nvim', requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}, config = require('plugins._telescope').config }

            -- A file explorer tree for neovim written in lua
            use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons', config = require('plugins._nvimtree').config }

            -- Vim plugin, insert or delete brackets, parens, quotes in pair 
            use 'jiangmiao/auto-pairs'

            -- endwise.vim: wisely add "end" in ruby, endfunction/endif/more in vim script, etc 
            use 'tpope/vim-endwise'

            -- A solid language pack for Vim.
            use 'sheerun/vim-polyglot'

            use { 'neoclide/coc.nvim', branch = 'release' }
        end,
        config = {
            display = {
                open_fn = require('packer.util').float
            }
        }
    }
)
