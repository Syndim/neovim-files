local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone --depth=1 https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end

-- Only required if you have packer configured as `opt`
-- vim.cmd [[packadd packer.nvim]]

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(
{
        function(use)
            -- Package menagement
            -- Packer can manage itself as an optional plugin
            use 'wbthomason/packer.nvim'

            -- Helper for lua config
            -- Neovim plugin that allows you to easily write your .vimrc in lua or any lua based language
            use 'svermeulen/vimpeccable'

            -- Editor interface
            -- A snazzy bufferline for Neovim
            use { 'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons', config = require('plugins._bufferline').config }

            -- A blazing fast and easy to configure neovim statusline written in pure lua.
            use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }, config = require('plugins._lualine').config }

            -- Clean, vibrant and pleasing color schemes for Vim, Sublime Text, iTerm, gnome-terminal and more. 
            use { 'sonph/onehalf', rtp = 'vim', config = require('plugins._color').config }

            -- Editor functionality
            -- A small automated session manager for Neovim
            use { 'rmagatti/auto-session', config = require('plugins._auto_session').config }

            -- Peek lines just when you intend
            use { 'nacro90/numb.nvim', config = require('plugins._numb').config }

            -- Easily jump between NeoVim windows.
            use { 'https://gitlab.com/yorickpeterse/nvim-window.git', as = "nvim-window", config = require('plugins._nvim_window').config }

            -- A file explorer tree for neovim written in lua
            local nvim_tree_config = require('plugins._nvimtree')
            use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons', setup = nvim_tree_config.setup, config = nvim_tree_config.config }

            -- Vim motions on speed!
            use 'easymotion/vim-easymotion'

            -- Multiple cursors plugin for vim/neovim
            use 'mg979/vim-visual-multi'

            -- Git integration for buffers
            use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' }, tag = 'release', config = require('plugins._gitsigns').config }

            -- Hlsearch Lens for Neovim
            use { 'kevinhwang91/nvim-hlslens', config = require('plugins._nvim_hlslens').config }

            -- A command-line fuzzy finder
            use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end, require = { 'junegunn/fzf' } }

            -- Find, Filter, Preview, Pick. All lua, all the time.
            use { 'nvim-telescope/telescope.nvim', config = require('plugins._telescope').config }

            --  FZY style sorter that is compiled
            use { 'nvim-telescope/telescope-fzy-native.nvim', requires = 'nvim-telescope/telescope.nvim', config = require('plugins._telescope_fzy_native').config }

            -- A neovim lua plugin to help easily manage multiple terminal windows
            use { 'akinsho/toggleterm.nvim', config = require('plugins._toggleterm').config }

            -- Delete Neovim buffers without losing window layout
            use 'famiu/bufdelete.nvim'

            -- Language support
            -- Generic
            -- Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
            -- use { 'dense-analysis/ale', setup = require('plugins._ale').setup }

            -- Vim plugin, insert or delete brackets, parens, quotes in pair
            use 'jiangmiao/auto-pairs'

            -- endwise.vim: wisely add "end" in ruby, endfunction/endif/more in vim script, etc
            use 'tpope/vim-endwise'

            -- commentary.vim: comment stuff out
            use { 'tpope/vim-commentary', setup = require('plugins._commentary').setup }

            -- Vim plugin that displays tags in a window, ordered by scope
            use { 'preservim/tagbar', setup = require('plugins._tagbar').setup }

            -- Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc.
            use 'Raimondi/delimitMate'

            -- Nvim Treesitter configurations and abstraction layer
            use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = require('plugins._treesitter').config }
            -- 🌈 Rainbow parentheses for neovim using tree-sitter 🌈
            use { 'p00f/nvim-ts-rainbow', requires = 'nvim-treesitter/nvim-treesitter' }
            -- Show code context
            -- Disabled for now
            use { 'romgrk/nvim-treesitter-context', requires = 'nvim-treesitter/nvim-treesitter', config = require('plugins._treesitter_context').config }
            -- 🌅 Twilight is a Lua plugin for Neovim 0.5 that dims inactive portions of the code you're editing using TreeSitter.
            -- use { 'folke/twilight.nvim', requires = 'nvim-treesitter/nvim-treesitter', config = require('plugins._twilight').config }
            -- Use treesitter to auto close and auto rename html tag
            use { 'windwp/nvim-ts-autotag', requires = 'nvim-treesitter/nvim-treesitter', config = require('plugins._nvim_ts_autotag').config }
            -- Treesitter playground integrated into Neovim
            use { 'nvim-treesitter/playground', requires = 'nvim-treesitter/nvim-treesitter' }

            -- LSP and auto completion
            -- Quickstart configurations for the Nvim LSP client
            use 'neovim/nvim-lspconfig'

            -- Neovim plugin that allows you to seamlessly manage LSP servers with :LspInstall. With full Windows support!
            use { 'williamboman/nvim-lsp-installer', config = require('plugins._lsp_installer').config }

            -- A completion plugin for neovim coded in Lua.
            use { 'hrsh7th/nvim-cmp', config = require('plugins._cmp').config }

            -- nvim-cmp source for neovim builtin LSP client
            use 'hrsh7th/cmp-nvim-lsp'

            -- nvim-cmp source for path
            use 'hrsh7th/cmp-path'

            -- nvim-cmp source for vim-vsnip
            use 'hrsh7th/cmp-vsnip'

            -- Snippet plugin for vim/nvim that supports LSP/VSCode's snippet format.
            use 'hrsh7th/vim-vsnip'

            -- nvim-cmp source for buffer words
            use 'hrsh7th/cmp-buffer'

            -- nvim-cmp source for nvim lua
            use 'hrsh7th/cmp-nvim-lua'

            -- nvim-cmp source for vim's cmdline
            use 'hrsh7th/cmp-cmdline'

            -- cmp-nvim-lsp-signature-help
            use 'hrsh7th/cmp-nvim-lsp-signature-help'

            -- Set of preconfigured snippets for different languages.
            use 'rafamadriz/friendly-snippets'

            -- Utility functions for getting diagnostic status and progress messages from LSP servers, for use in the Neovim statusline
            use 'nvim-lua/lsp-status.nvim'

            -- C/C++
            -- c or cpp syntax files
            use 'vim-jp/vim-cpp'

            -- Clangd's off-spec features for neovim's LSP client
            use { 'p00f/clangd_extensions.nvim', config = require('plugins._clangd').config }

            -- C#
            -- use { 'OmniSharp/omnisharp-vim', run = ':OmniSharpInstall', rtp = '', setup = require('plugins._omnisharp').setup }

            -- Rust
            -- Vim configuration for Rust.
            use 'rust-lang/rust.vim'

            -- Tools for better development in rust using neovim's builtin lsp
            use 'simrat39/rust-tools.nvim'

            -- A neovim plugin that helps managing crates.io dependencies
            use { 'saecki/crates.nvim', requires = { 'nvim-lua/plenary.nvim' }, config = function() require('crates').setup() end }

            -- Python
            --  A vim plugin to display the indention levels with thin vertical lines
            use 'Yggdroot/indentLine'

            -- Ruby
            -- Vim/Ruby Configuration Files
            use 'vim-ruby/vim-ruby'

            -- rails.vim: Ruby on Rails power tools
            use 'tpope/vim-rails'

            -- rake.vim: it's like rails.vim without the rails
            use 'tpope/vim-rake'

            -- Typescript
            -- Typescript syntax files for Vim
            use 'leafgarland/typescript-vim'

            -- React JSX syntax highlighting for vim and Typescript
            use 'peitalin/vim-jsx-typescript'

            -- HTML/CSS
            -- Automatically closes HTML tags once you finish typing them.
            use 'vim-scripts/HTML-AutoCloseTag'

            -- CSS3 syntax (and syntax defined in some foreign specifications) support for Vim's built-in syntax/css.vim
            use 'hail2u/vim-css3-syntax'

            -- emmet for vim: http://emmet.io/
            use 'mattn/emmet-vim'

            -- extended % matching for HTML, LaTeX, and many other languages
            use 'vim-scripts/matchit.zip'

            -- Markdown
            -- Markdown Vim Mode
            use 'plasticboy/vim-markdown'

            -- Dart & Flutter
            -- Syntax highlighting for Dart in Vim
            use { 'dart-lang/dart-vim-plugin', setup = require('plugins._dart').setup }

            -- Tools to help create flutter apps in neovim using the native lsp
            use { 'akinsho/flutter-tools.nvim', requires = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' }, config = require('plugins._flutter').config }

            -- nu-shell
            use { 'LhKipp/nvim-nu', requires = { 'jose-elias-alvarez/null-ls.nvim' }, config = require('plugins._nvim_nu').config }

            if packer_bootstrap then
                require('packer').sync()
            end
        end,
        config = {
            display = {
                open_fn = require('packer.util').float
            },
            git = {
                clone_timeout = 600,
            },
            log = {
                level = 'info'
            }
        }
}
)
