local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup(
    {
        -- Package menagement
        -- 💤 A modern plugin manager for Neovim
        'folke/lazy.nvim',

        -- Editor interface
        -- Indent guides for Neovim
        {
            'lukas-reineke/indent-blankline.nvim',
            event = 'BufReadPost',
            config = require('plugins._indent_blankline').config
        },

        -- Neovim Lua plugin to visualize and operate on indent scope.
        {
            'echasnovski/mini.indentscope',
            version = false, -- wait till new 0.7.0 release to put it back on semver
            event = 'BufReadPre',
            config = require('plugins._mini_indent_scope').config,
        },

        -- illuminate.vim - (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
        {
            'RRethy/vim-illuminate',
            event = 'BufReadPost',
            config = require('plugins._vim_illuminate').config
        },

        {
            'folke/todo-comments.nvim',
            dependencies = 'nvim-lua/plenary.nvim',
            event = "BufReadPost",
            config = require('plugins._todo_comments').config
        },

        -- Treesitter powered spellchecker
        { 'lewis6991/spellsitter.nvim', config = function() require('spellsitter').setup() end, event = 'BufRead' },

        -- A fancy, configurable, notification manager for NeoVim
        {
            'rcarriga/nvim-notify',
            config = require('plugins._notify').config,
            lazy = false,
        },

        -- 💥 Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
        { 'folke/which-key.nvim',       config = require('plugins._which_key').config,          lazy = false },

        --  Extensible Neovim Scrollbar
        {
            'petertriho/nvim-scrollbar',
            dependencies = 'kevinhwang91/nvim-hlslens',
            config = require('plugins._scrollbar').config,
            event = 'BufRead'
        },

        -- Clipboard manager neovim plugin with telescope integration
        {
            'AckslD/nvim-neoclip.lua',
            dependencies = { 'nvim-telescope/telescope.nvim', 'kkharji/sqlite.lua' },
            config = require('plugins._neoclip').config,
            event = 'BufRead'
        },

        -- Integrates vim-bookmarks into telescope.nvim
        {
            'tom-anders/telescope-vim-bookmarks.nvim',
            dependencies = 'MattesGroeger/vim-bookmarks',
            config = require('plugins._bookmarks').config,
            init = require('plugins._bookmarks').setup,
            event = 'BufEnter'
        },

        -- A telescope.nvim extension that offers intelligent prioritization when selecting files from your editing history.
        {
            'nvim-telescope/telescope-frecency.nvim',
            dependencies = { 'nvim-telescope/telescope.nvim', 'kkharji/sqlite.lua' },
            config = require('plugins._telescope_frecency').config,
            event = 'BufEnter'
        },

        --  The fastest Neovim colorizer.
        { 'norcalli/nvim-colorizer.lua', config = require('plugins._colorizer').config, event = 'BufRead' },

        -- A snazzy bufferline for Neovim
        {
            'akinsho/bufferline.nvim',
            dependencies = 'kyazdani42/nvim-web-devicons',
            config = require('plugins._bufferline').config,
            event = 'VeryLazy'
        },

        -- A blazing fast and easy to configure neovim statusline written in pure lua.
        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'kyazdani42/nvim-web-devicons', opt = true },
            after = 'onedark.nvim',
            config = require('plugins._lualine').config,
            event = 'VeryLazy'
        },

        -- Clean, vibrant and pleasing color schemes for Vim, Sublime Text, iTerm, gnome-terminal and more.
        { 'navarasu/onedark.nvim',       config = require('plugins._color').config,     lazy = false },

        -- Editor functionality
        {
            'Shatur/neovim-session-manager',
            dependencies = 'nvim-lua/plenary.nvim',
            config = require('plugins._nvim_session_manager').config,
            event = 'BufEnter'
        },

        -- Peek lines just when you intend
        { 'nacro90/numb.nvim',         config = require('plugins._numb').config, event = 'BufRead' },

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
        {
            'stevearc/dressing.nvim',
            config = require('plugins._dressing').config,
            init = require('plugins._dressing').init
        },

        -- Vim motions on speed!
        { 'easymotion/vim-easymotion', event = 'BufReadPost' },

        -- Multiple cursors plugin for vim/neovim
        { 'mg979/vim-visual-multi',    event = 'BufReadPost' },

        -- Git integration for buffers
        {
            'lewis6991/gitsigns.nvim',
            dependencies = { 'nvim-lua/plenary.nvim' },
            tag = 'release',
            config = require('plugins._gitsigns').config,
            event = 'BufRead'
        },

        -- Hlsearch Lens for Neovim
        { 'kevinhwang91/nvim-hlslens',     config = require('plugins._nvim_hlslens').config, event = 'BufRead' },

        -- Find, Filter, Preview, Pick. All lua, all the time.
        { 'nvim-telescope/telescope.nvim', config = require('plugins._telescope').config,    event = 'BufEnter' },

        -- FZY style sorter that is compiled
        {
            'nvim-telescope/telescope-fzy-native.nvim',
            dependencies = 'nvim-telescope/telescope.nvim',
            config = require('plugins._telescope_fzy_native').config,
            event = 'BufEnter'
        },

        {
            'nvim-telescope/telescope-ui-select.nvim',
            dependencies = 'nvim-telescope/telescope.nvim',
            config = require('plugins._telescope_ui_select').config,
            event = 'BufEnter'
        },

        -- Find the enemy and replace them with dark power.
        {
            'windwp/nvim-spectre',
            keys = {
                { '<leader>s' },
            },
            config = require('plugins._nvim_spectre').config
        },

        -- A neovim lua plugin to help easily manage multiple terminal windows
        { 'akinsho/toggleterm.nvim',       config = require('plugins._toggleterm').config,      lazy = false },

        -- Delete Neovim buffers without losing window layout
        { 'famiu/bufdelete.nvim',          lazy = false },

        -- surround.vim: Delete/change/add parentheses/quotes/XML-tags/much more with ease
        { 'tpope/vim-surround',            event = 'BufReadPost' },

        -- Language support
        -- Generic
        -- 🧠 💪 // Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
        { 'numToStr/Comment.nvim',         config = require('plugins._comment').config,         event = 'BufReadPost' },

        -- A solid language pack for Vim. 
        { 'sheerun/vim-polyglot', event = 'BufReadPost'}
        -- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
        { 'simrat39/symbols-outline.nvim', config = require('plugins._symbols_outline').config, event = 'BufReadPost' },

        -- Nvim Treesitter configurations and abstraction layer
        {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = require('plugins._treesitter').config,
            version = false,
            event = 'BufReadPost'
        },

        -- 🌈 Rainbow parentheses for neovim using tree-sitter 🌈
        { 'p00f/nvim-ts-rainbow',            dependencies = 'nvim-treesitter/nvim-treesitter', event = 'BufReadPost' },

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
            event = 'BufRead'
        },

        -- LSP and auto completion
        -- Extension to mason.nvim that makes it easier to lspconfig with mason.nvim
        {
            'williamboman/mason-lspconfig.nvim',
            dependencies = { 'williamboman/mason.nvim', 'neovim/nvim-lspconfig' },
            config = require('plugins._mason_lspconfig').config,
            event = 'BufEnter'
        },

        {
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            dependencies = { 'williamboman/mason.nvim' },
            config = require('plugins._mason_tool_installer').config,
            event = 'BufEnter'
        },

        -- Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
        { 'jose-elias-alvarez/null-ls.nvim', config = require('plugins._null_ls').config,      event = 'BufEnter' },

        -- A completion plugin for neovim coded in Lua.
        { 'hrsh7th/nvim-cmp', config = require('plugins._cmp').config, event = { 'InsertEnter', 'CmdlineEnter' },
            version = false,
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

                -- A neovim plugin that helps managing crates.io dependencies
                {
                    'saecki/crates.nvim',
                    dependencies = { 'nvim-lua/plenary.nvim' },
                    config = require('plugins._crates').config,
                },
            } },

        -- Quickfix
        -- 🚦 A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
        { 'folke/trouble.nvim',                config = require('plugins._trouble').config, event = 'BufRead' },

        -- 🌸 A command-line fuzzy finder
        { 'junegunn/fzf' },
        -- Better quickfix window in Neovim, polish old quickfix window.
        { 'kevinhwang91/nvim-bqf',             ft = 'qf' },

        -- C/C++
        -- Clangd's off-spec features for neovim's LSP client
        { 'p00f/clangd_extensions.nvim',       config = require('plugins._clangd').config,  ft = { 'c', 'cpp', 'h', 'hpp' } },

        -- C#
        -- Extended 'textDocument/definition' handler for OmniSharp Neovim LSP
        { 'Hoffs/omnisharp-extended-lsp.nvim', ft = 'cs' },

        -- Rust
        -- Vim configuration for Rust.
        { 'rust-lang/rust.vim',                ft = 'rust' },

        -- Tools for better development in rust using neovim's builtin lsp
        { 'simrat39/rust-tools.nvim',          ft = 'rust' },

        -- Ruby
        -- Vim/Ruby Configuration Files
        { 'vim-ruby/vim-ruby',                 ft = 'ruby' },

        -- rake.vim: it's like rails.vim without the rails
        { 'tpope/vim-rake',                    ft = 'ruby' },

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
        { 'leafgarland/typescript-vim',  ft = 'typescript' },

        -- React JSX syntax highlighting for vim and Typescript
        { 'peitalin/vim-jsx-typescript', ft = { 'javascriptreact', 'typescriptreact' } },

        -- HTML/CSS
        -- emmet for vim: http://emmet.io/
        { 'mattn/emmet-vim',             ft = { 'html', 'javascriptreact', 'typescriptreact' } },

        -- Dart & Flutter
        -- Syntax highlighting for Dart in Vim
        { 'dart-lang/dart-vim-plugin',   init = require('plugins._dart').setup,                ft = 'dart' },

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
