local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        'https://github.com/folke/lazy.nvim.git',
        lazypath,
    })
end

vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup(
    {
        -- Package menagement
        -- 💤 A modern plugin manager for Neovim
        'folke/lazy.nvim',

        -- Editor interface
        -- Treesitter powered spellchecker
        { 'lewis6991/spellsitter.nvim', config = function() require('spellsitter').setup() end, event = 'BufEnter' },

        -- A fancy, configurable, notification manager for NeoVim
        { 'rcarriga/nvim-notify', config = require('plugins._notify').config, lazy = false },

        -- 💥 Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
        { 'folke/which-key.nvim', config = require('plugins._which_key').config, lazy = false },

        --  Extensible Neovim Scrollbar
        {
            'petertriho/nvim-scrollbar',
            dependencies = 'kevinhwang91/nvim-hlslens',
            config = require('plugins._scrollbar').config,
            lazy = false
        },

        -- Clipboard manager neovim plugin with telescope integration
        { 'AckslD/nvim-neoclip.lua',
            dependencies = { 'nvim-telescope/telescope.nvim', { 'tami5/sqlite.lua', module = 'sqlite' } },
            config = require('plugins._neoclip').config,
            lazy = false },

        -- Integrates vim-bookmarks into telescope.nvim
        {
            'tom-anders/telescope-vim-bookmarks.nvim',
            dependencies = 'MattesGroeger/vim-bookmarks',
            config = require('plugins._bookmarks').config,
            init = require('plugins._bookmarks').setup,
            lazy = false
        },

        --  The fastest Neovim colorizer.
        { 'norcalli/nvim-colorizer.lua', config = require('plugins._colorizer').config, event = 'BufEnter' },

        -- A snazzy bufferline for Neovim
        {
            'akinsho/bufferline.nvim',
            dependencies = 'kyazdani42/nvim-web-devicons',
            config = require('plugins._bufferline').config,
            event = 'BufEnter'
        },

        -- A blazing fast and easy to configure neovim statusline written in pure lua.
        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
            after = 'onedark.nvim',
            config = require('plugins._lualine').config,
            event = 'BufEnter'
        },

        -- Clean, vibrant and pleasing color schemes for Vim, Sublime Text, iTerm, gnome-terminal and more.
        { 'navarasu/onedark.nvim', config = require('plugins._color').config, lazy = false },

        -- Editor functionality
        {
            'Shatur/neovim-session-manager',
            dependencies = 'nvim-lua/plenary.nvim',
            config = require('plugins._nvim_session_manager').config,
            lazy = false
        },

        -- Peek lines just when you intend
        { 'nacro90/numb.nvim', config = require('plugins._numb').config, event = 'BufEnter' },

        -- Easily jump between NeoVim windows.
        {
            url = 'https://gitlab.com/yorickpeterse/nvim-window.git',
            name = 'nvim-window',
            config = require('plugins._nvim_window').config,
            lazy = false
        },

        -- Neovim plugin to manage the file system and other tree like structures.
        {
            'nvim-neo-tree/neo-tree.nvim',
            branch = 'v2.x',
            dependencies = { 'nvim-lua/plenary.nvim', 'kyazdani42/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
            config = require('plugins._neo_tree').config,
            keys = {
                { '<F2>' },
                { '<F3>' }
            }
        },

        -- Neovim plugin to improve the default vim.ui interfaces
        { 'stevearc/dressing.nvim', config = require('plugins._dressing').config, lazy = false },

        -- Vim motions on speed!
        { 'easymotion/vim-easymotion', event = 'BufEnter' },

        -- Multiple cursors plugin for vim/neovim
        { 'mg979/vim-visual-multi', event = 'BufEnter' },

        -- Git integration for buffers
        {
            'lewis6991/gitsigns.nvim',
            dependencies = { 'nvim-lua/plenary.nvim' },
            tag = 'release',
            config = require('plugins._gitsigns').config,
            event = 'BufEnter'
        },

        -- Hlsearch Lens for Neovim
        { 'kevinhwang91/nvim-hlslens', config = require('plugins._nvim_hlslens').config, event = 'BufEnter' },

        -- Find, Filter, Preview, Pick. All lua, all the time.
        { 'nvim-telescope/telescope.nvim', config = require('plugins._telescope').config, lazy = false },

        -- FZY style sorter that is compiled
        {
            'nvim-telescope/telescope-fzy-native.nvim',
            dependencies = 'nvim-telescope/telescope.nvim',
            config = require('plugins._telescope_fzy_native').config,
            lazy = false
        },

        {
            'nvim-telescope/telescope-live-grep-args.nvim',
            dependencies = 'nvim-telescope/telescope.nvim',
            config = require('plugins._telescope_rg').config,
            event = 'BufEnter'
        },

        {
            'nvim-telescope/telescope-ui-select.nvim',
            dependencies = 'nvim-telescope/telescope.nvim',
            config = require('plugins._telescope_ui_select').config,
            lazy = false
        },

        -- A neovim lua plugin to help easily manage multiple terminal windows
        { 'akinsho/toggleterm.nvim', config = require('plugins._toggleterm').config, lazy = false },

        -- Delete Neovim buffers without losing window layout
        { 'famiu/bufdelete.nvim', lazy = false },

        -- surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with ease
        { 'tpope/vim-surround', event = 'BufEnter' },

        -- Language support
        -- Generic
        -- 🧠 💪 // Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
        { 'numToStr/Comment.nvim', config = require('plugins._comment').config, event = 'BufEnter' },

        -- Vim plugin that displays tags in a window, ordered by scope
        -- { 'preservim/tagbar', init =require('plugins._tagbar').setup }
        { 'simrat39/symbols-outline.nvim', config = require('plugins._symbols_outline').config, event = 'BufEnter' },

        -- Nvim Treesitter configurations and abstraction layer
        { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', config = require('plugins._treesitter').config,
            event = 'BufEnter' },

        -- 🌈 Rainbow parentheses for neovim using tree-sitter 🌈
        { 'p00f/nvim-ts-rainbow', dependencies = 'nvim-treesitter/nvim-treesitter', event = 'BufEnter' },

        -- treesitter to auto close and auto rename html tag
        {
            'windwp/nvim-ts-autotag',
            dependencies = 'nvim-treesitter/nvim-treesitter',
            config = require('plugins._treesitter_autotag').config,
            ft = { 'html', 'javascriptreact', 'typescriptreact' }
        },

        -- autopairs for neovim written by lua
        {
            'windwp/nvim-autopairs',
            dependencies = 'nvim-treesitter/nvim-treesitter',
            config = require('plugins._treesitter_autopair').config,
            event = 'BufEnter'
        },

        -- LSP and auto completion
        -- Extension to mason.nvim that makes it easier to lspconfig with mason.nvim
        {
            'williamboman/mason-lspconfig.nvim',
            dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
            config = require('plugins._mason_lspconfig').config,
            lazy = false
        },

        {
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            dependencies = { 'williamboman/mason.nvim' },
            config = require('plugins._mason_tool_installer').config,
            lazy = false
        },

        -- Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
        { 'jose-elias-alvarez/null-ls.nvim', config = require('plugins._null_ls').config, event = 'BufEnter' },

        -- A completion plugin for neovim coded in Lua.
        { 'hrsh7th/nvim-cmp', config = require('plugins._cmp').config, event = { 'InsertEnter', 'CmdlineEnter' },
            dependencies = {
                -- nvim-cmp source for neovim builtin LSP client
                'hrsh7th/cmp-nvim-lsp',

                -- nvim-cmp source for path
                'hrsh7th/cmp-path',

                -- nvim-cmp source for vim-vsnip
                'hrsh7th/cmp-vsnip',

                -- Snippet plugin for vim/nvim that supports LSP/VSCode's snippet format.
                'hrsh7th/vim-vsnip',

                -- nvim-cmp source for buffer words
                'hrsh7th/cmp-buffer',

                -- nvim-cmp source for nvim lua
                'hrsh7th/cmp-nvim-lua',

                -- nvim-cmp source for vim's cmdline
                'hrsh7th/cmp-cmdline',

                -- nvim-cmp source for textDocument/documentSymbol via nvim-lsp
                'hrsh7th/cmp-nvim-lsp-document-symbol',

                -- cmp-nvim-lsp-signature-help
                'hrsh7th/cmp-nvim-lsp-signature-help',

                -- vscode-like pictograms for neovim lsp completion items
                'onsails/lspkind.nvim',

                --  An additional source for nvim-cmp to autocomplete packages and its versions
                { 'David-Kunz/cmp-npm', config = function() require('cmp-npm').setup({}) end },

                --  tags sources for nvim-cmp
                'quangnguyen30192/cmp-nvim-tags',

                --  cmp source for treesitter
                'ray-x/cmp-treesitter',

                -- Set of preconfigured snippets for different languages.
                'rafamadriz/friendly-snippets',

                -- Utility functions for getting diagnostic status and progress messages from LSP servers, for in the Neovim statusline
                'nvim-lua/lsp-status.nvim',

            } },

        -- Quickfix
        -- 🚦 A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
        { 'folke/trouble.nvim', config = require('plugins._trouble').config, event = 'BufEnter' },

        -- 🌸 A command-line fuzzy finder
        { 'junegunn/fzf' },
        -- Better quickfix window in Neovim, polish old quickfix window.
        { 'kevinhwang91/nvim-bqf', ft = 'qf' },

        -- C/C++
        -- Clangd's off-spec features for neovim's LSP client
        { 'p00f/clangd_extensions.nvim', config = require('plugins._clangd').config, ft = { 'c', 'cpp', 'h', 'hpp' } },

        -- C#
        -- Extended 'textDocument/definition' handler for OmniSharp Neovim LSP
        { 'Hoffs/omnisharp-extended-lsp.nvim', ft = 'cs' },

        -- Rust
        -- Vim configuration for Rust.
        { 'rust-lang/rust.vim', ft = 'rust' },

        -- Tools for better development in rust using neovim's builtin lsp
        { 'simrat39/rust-tools.nvim', ft = 'rust' },

        -- A neovim plugin that helps managing crates.io dependencies
        {
            'saecki/crates.nvim',
            dependencies = { 'nvim-lua/plenary.nvim' },
            config = function() require('crates').setup() end,
            event = 'BufEnter Cargo.toml'
        },

        -- Python
        --  A vim plugin to display the indention levels with thin vertical lines
        { 'Yggdroot/indentLine', init = require('plugins._indent_line').setup, ft = 'python' },

        -- Ruby
        -- Vim/Ruby Configuration Files
        { 'vim-ruby/vim-ruby', ft = 'ruby' },

        -- rake.vim: it's like rails.vim without the rails
        { 'tpope/vim-rake', ft = 'ruby' },

        -- Just
        --  Treesitter grammar for Justfiles (casey/just)
        {
            'IndianBoy42/tree-sitter-just',
            dependencies = { 'nvim-treesitter/nvim-treesitter' },
            config = require('plugins._just').config,
            ft = 'just'
        },

        -- Typescript
        -- Typescript syntax files for Vim
        { 'leafgarland/typescript-vim', ft = 'typescript' },

        -- React JSX syntax highlighting for vim and Typescript
        { 'peitalin/vim-jsx-typescript', ft = { 'javascriptreact', 'typescriptreact' } },

        -- HTML/CSS
        -- emmet for vim: http://emmet.io/
        { 'mattn/emmet-vim', ft = { 'html', 'javascriptreact', 'typescriptreact' } },

        -- Markdown
        -- Markdown Vim Mode
        { 'plasticboy/vim-markdown', ft = 'markdown' },

        -- Dart & Flutter
        -- Syntax highlighting for Dart in Vim
        { 'dart-lang/dart-vim-plugin', init = require('plugins._dart').setup, ft = 'dart' },

        -- Tools to help create flutter apps in neovim using the native lsp
        { 'akinsho/flutter-tools.nvim', dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
            ft = 'dart' },

        -- nu-shell
        {
            'LhKipp/nvim-nu',
            dependencies = { 'jose-elias-alvarez/null-ls.nvim', 'nvim-treesitter/nvim-treesitter' },
            config = require('plugins._nvim_nu').config,
            ft = 'nu'
        },

        -- Others
        -- Fix CursorHold Performance.
        { 'antoinemadec/FixCursorHold.nvim', init = require('plugins._fix_cursor_hold').setup, lazy = false },

    },
    {
        defaults = {
            lazy = true,
            version = '*'
        },
        git = {
            timeout = 600,
        },
    }
)
