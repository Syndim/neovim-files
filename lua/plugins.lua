local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone --depth=1 https://ghproxy.com/https://github.com/wbthomason/packer.nvim '..install_path)
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
                -- Clean, vibrant and pleasing color schemes for Vim, Sublime Text, iTerm, gnome-terminal and more. 
                use { 'sonph/onehalf', rtp = 'vim', config = require('plugins._color').config }

                -- A snazzy bufferline for Neovim
                use { 'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons', config = require('plugins._bufferline').config }

                -- A blazing fast and easy to configure neovim statusline written in pure lua.
                use { 'hoob3rt/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true }, config = require('plugins._lualine').config }

            -- Editor functionality
                -- A small automated session manager for Neovim
                use { 'rmagatti/auto-session', config = require('plugins._auto_session').config }
                
                -- Peek lines just when you intend
                use { 'nacro90/numb.nvim', config = require('plugins._numb').config }

                -- Auto-Focusing and Auto-Resizing Splits/Windows for Neovim written in Lua. A full suite of window management enhancements. Vim splits on steroids!
                -- use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end }

                -- Easily jump between NeoVim windows.
                use { 'https://gitlab.com/yorickpeterse/nvim-window.git', as = "nvim-window", config = require('plugins._nvim_window').config }

                -- A file explorer tree for neovim written in lua
                use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons', config = require('plugins._nvimtree').config }

                -- Vim motions on speed!
                use 'easymotion/vim-easymotion'

                -- Multiple cursors plugin for vim/neovim
                use 'mg979/vim-visual-multi'

                -- A very simple plugin that makes hlsearch more useful.
                -- use 'romainl/vim-cool'

                -- A Vim plugin which shows git diff markers in the sign column and stages/previews/undoes hunks and partial hunks. 
                use 'airblade/vim-gitgutter'

                -- Hlsearch Lens for Neovim
                use { 'kevinhwang91/nvim-hlslens', config = require('plugins._nvim_hlslens').config }

                -- Helps you win at grep.
                -- use 'mhinz/vim-grepper'

                -- A command-line fuzzy finder
                use { 'junegunn/fzf', run = function() vim.fn['fzf#install']() end }
                -- fzf ❤️ vim
                use 'junegunn/fzf.vim'

                -- 🔥 No-nonsense floating terminal written in lua 🔥
                use { "akinsho/nvim-toggleterm.lua", config = require('plugins._toggleterm').config }

            -- Language support
                -- Generic
                    -- A solid language pack for Vim.
                    -- use 'sheerun/vim-polyglot'

                    -- Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support 
                    use 'dense-analysis/ale'

                    -- Vim plugin, insert or delete brackets, parens, quotes in pair 
                    use 'jiangmiao/auto-pairs'

                    -- endwise.vim: wisely add "end" in ruby, endfunction/endif/more in vim script, etc 
                    use 'tpope/vim-endwise'

                    -- commentary.vim: comment stuff out 
                    use 'tpope/vim-commentary'

                    -- Vim plugin that displays tags in a window, ordered by scope 
                    use 'preservim/tagbar'

                    -- vim-snipmate default snippets (Previously snipmate-snippets) 
                    use 'honza/vim-snippets'

                    -- Vim plugin, provides insert mode auto-completion for quotes, parens, brackets, etc. 
                    use 'Raimondi/delimitMate'

                    -- Nodejs extension host for vim & neovim, load extensions like VSCode and host language servers.
                    use { 'neoclide/coc.nvim', branch = 'release' }

                    -- Nvim Treesitter configurations and abstraction layer 
                    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = require('plugins._treesitter').config }
                        -- 🌈 Rainbow parentheses for neovim using tree-sitter 🌈
                        use { 'p00f/nvim-ts-rainbow', requires = 'nvim-treesitter/nvim-treesitter' }
                        -- Show code context
                        use { 'romgrk/nvim-treesitter-context', requires = 'nvim-treesitter/nvim-treesitter', config = require('plugins._treesitter_context').config }
                        -- 🌅 Twilight is a Lua plugin for Neovim 0.5 that dims inactive portions of the code you're editing using TreeSitter.
                        -- use { 'folke/twilight.nvim', requires = 'nvim-treesitter/nvim-treesitter', config = require('plugins._twilight').config }
                        -- Use treesitter to auto close and auto rename html tag
                        use { 'windwp/nvim-ts-autotag', requires = 'nvim-treesitter/nvim-treesitter', config = require('plugins._nvim_ts_autotag').config }
                        -- Treesitter playground integrated into Neovim
                        use { 'nvim-treesitter/playground', requires = 'nvim-treesitter/nvim-treesitter' }

                -- C/C++
                    -- Alternate Files quickly (.c --> .h etc) 
                    use 'vim-scripts/a.vim'

                    -- c or cpp syntax files 
                    use 'vim-jp/vim-cpp'

                -- C#
                    use { 'OmniSharp/omnisharp-vim', run = ':OmniSharpInstall', rtp = '' }

                -- Rust
                    -- Vim configuration for Rust. 
                    use 'rust-lang/rust.vim'

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
                default_url_format = 'https://ghproxy.com/https://github.com/%s'
            },
            log = {
                level = 'info'
            }
        }
    }
)
