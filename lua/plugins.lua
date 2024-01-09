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

local global = require('global')
local is_not_embedded = not global.is_embedded

require('lazy').setup(
    {
        -- Package menagement
        -- 💤 A modern plugin manager for Neovim
        'folke/lazy.nvim',

        -- Editor interface
        -- Open files and command output from neovim terminals in your current neovim instance
        {
            'willothy/flatten.nvim',
            -- config = true,
            -- or pass configuration with
            opts = {},
            -- Ensure that it runs first to minimize delay when opening file from terminal
            lazy = false,
            priority = 1001,
            cond = is_not_embedded
        },

        -- Indent guides for Neovim
        {
            'lukas-reineke/indent-blankline.nvim',
            event = 'BufReadPost',
            config = require('plugins._indent_blankline').config,
            cond = is_not_embedded
        },

        -- Neovim Lua plugin to visualize and operate on indent scope.
        {
            'echasnovski/mini.indentscope',
            version = false, -- wait till new 0.7.0 release to put it back on semver
            event = 'BufReadPost',
            config = require('plugins._mini_indent_scope').config,
        },

        -- Neovim Lua plugin with fast and feature-rich surround actions. Part of 'mini.nvim' library.
        {
            'echasnovski/mini.surround',
            version = '*',
            event = 'BufReadPost',
            config = require('plugins._mini_surround').config,
            cond = is_not_embedded
        },

        -- illuminate.vim - (Neo)Vim plugin for automatically highlighting other uses of the word under the cursor using either LSP, Tree-sitter, or regex matching.
        {
            'RRethy/vim-illuminate',
            event = 'BufReadPost',
            config = require('plugins._vim_illuminate').config
        },

        -- ✅ Highlight, list and search todo comments in your projects
        {
            'folke/todo-comments.nvim',
            dependencies = 'nvim-lua/plenary.nvim',
            event = 'BufReadPost',
            config = require('plugins._todo_comments').config
        },

        -- A fancy, configurable, notification manager for NeoVim
        {
            'rcarriga/nvim-notify',
            config = require('plugins._notify').config,
            lazy = false,
            cond = is_not_embedded
        },

        -- Extensible UI for Neovim notifications and LSP progress messages.
        {
            'j-hui/fidget.nvim',
            config = require('plugins._fidget').config,
            lazy = false,
            cond = is_not_embedded
        },

        -- 💥 Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
        {
            'folke/which-key.nvim',
            config = require('plugins._which_key').config,
            lazy = false,
            cond = is_not_embedded,
        },

        --  Extensible Neovim Scrollbar
        {
            'petertriho/nvim-scrollbar',
            dependencies = 'kevinhwang91/nvim-hlslens',
            config = require('plugins._scrollbar').config,
            event = 'BufReadPost',
            cond = is_not_embedded
        },

        -- Status column plugin that provides a configurable 'statuscolumn' and click handlers.
        {
            'luukvbaal/statuscol.nvim',
            config = require('plugins._statuscol').config,
            event = 'BufReadPost',
            cond = is_not_embedded
        },

        -- Clipboard manager neovim plugin with telescope integration
        {
            'AckslD/nvim-neoclip.lua',
            dependencies = { 'nvim-telescope/telescope.nvim', 'kkharji/sqlite.lua' },
            config = require('plugins._neoclip').config,
            event = 'BufReadPost',
            cond = is_not_embedded
        },

        -- Integrates vim-bookmarks into telescope.nvim
        {
            'tom-anders/telescope-vim-bookmarks.nvim',
            dependencies = 'MattesGroeger/vim-bookmarks',
            config = require('plugins._bookmarks').config,
            init = require('plugins._bookmarks').setup,
            event = 'BufEnter',
            cond = is_not_embedded
        },

        --  The fastest Neovim colorizer.
        {
            'norcalli/nvim-colorizer.lua',
            config = require('plugins._colorizer').config,
            event = 'VeryLazy',
            cond = is_not_embedded
        },

        -- A snazzy bufferline for Neovim
        {
            'akinsho/bufferline.nvim',
            dependencies = 'kyazdani42/nvim-web-devicons',
            config = require('plugins._bufferline').config,
            event = 'VeryLazy',
            cond = is_not_embedded
        },

        -- A blazing fast and easy to configure neovim statusline written in pure lua.
        {
            'nvim-lualine/lualine.nvim',
            dependencies = {
                { 'kyazdani42/nvim-web-devicons', opt = true },
                'nvim-lua/lsp-status.nvim',
            },
            config = require('plugins._lualine').config,
            event = 'VeryLazy',
            cond = is_not_embedded
        },

        -- 🍨 Soothing pastel theme for (Neo)vim
        {
            'catppuccin/nvim',
            name = 'catppuccin',
            config = require('plugins._color').config,
            priority = 1000,
            lazy = false,
            -- cond = is_not_embedded
        },

        -- A small automated session manager for Neovim
        {
            'rmagatti/auto-session',
            dependencies = 'nvim-lua/plenary.nvim',
            config = require('plugins._auto_session').config,
            event = 'BufEnter',
            cond = is_not_embedded
        },

        -- Peek lines just when you intend
        {
            'nacro90/numb.nvim',
            config = require('plugins._numb').config,
            event = 'BufReadPost'
        },

        -- A file explorer tree for neovim written in lua
        {
            'nvim-tree/nvim-tree.lua',
            dependencies = { 'kyazdani42/nvim-web-devicons' },
            config = require('plugins._nvim_tree').config,
            keys = {
                { '<F2>' },
                { '<F3>' },
            },
            cond = is_not_embedded
        },

        -- Neovim plugin to improve the default vim.ui interfaces
        {
            'stevearc/dressing.nvim',
            config = require('plugins._dressing').config,
            init = require('plugins._dressing').init,
            cond = is_not_embedded
        },

        -- Navigate your code with search labels, enhanced character motions and Treesitter integration
        {
            'folke/flash.nvim',
            event = 'VeryLazy',
            config = require('plugins._flash').config,
            keys = {
                {
                    's<CR>',
                    mode = { 'n', 'x', 'o' },
                    function()
                        require('flash').jump({ continue = true })
                    end,
                    desc = 'Flash',
                },
                {
                    's',
                    mode = { 'n', 'x', 'o' },
                    function()
                        require('flash').jump()
                    end,
                    desc = 'Flash',
                },
                {
                    'r',
                    mode = 'o',
                    function()
                        require('flash').remote()
                    end,
                    desc = 'Remote Flash',
                },
                {
                    '<c-s>',
                    mode = { 'c' },
                    function()
                        require('flash').toggle()
                    end,
                    desc = 'Toggle Flash Search',
                },
            },
        },

        -- Multiple cursors plugin for vim/neovim
        { 'mg979/vim-visual-multi', event = 'BufReadPost' },

        -- Hover plugin framework for Neovim
        {
            'lewis6991/hover.nvim',
            config = require('plugins._hover').config,
            event = 'BufReadPost',
            cond = is_not_embedded
        },

        -- Git integration for buffers
        {
            'lewis6991/gitsigns.nvim',
            dependencies = { 'nvim-lua/plenary.nvim' },
            tag = 'release',
            config = require('plugins._gitsigns').config,
            event = 'BufReadPost',
            cond = is_not_embedded
        },

        -- Find, Filter, Preview, Pick. All lua, all the time.
        {
            'nvim-telescope/telescope.nvim',
            config = require('plugins._telescope').config,
            event = 'BufEnter',
            cond = is_not_embedded
        },

        -- FZY style sorter that is compiled
        {
            'nvim-telescope/telescope-fzy-native.nvim',
            dependencies = 'nvim-telescope/telescope.nvim',
            config = require('plugins._telescope_fzy_native').config,
            event = 'BufEnter',
            cond = is_not_embedded
        },

        {
            'nvim-telescope/telescope-ui-select.nvim',
            dependencies = 'nvim-telescope/telescope.nvim',
            config = require('plugins._telescope_ui_select').config,
            event = 'BufEnter',
            cond = is_not_embedded
        },

        -- Find the enemy and replace them with dark power.
        {
            'windwp/nvim-spectre',
            keys = {
                { '<leader>s' },
            },
            config = require('plugins._nvim_spectre').config,
            cond = is_not_embedded
        },

        -- A neovim lua plugin to help easily manage multiple terminal windows
        {
            'akinsho/toggleterm.nvim',
            config = require('plugins._toggleterm').config,
            lazy = false,
            cond = is_not_embedded,
        },

        -- Delete Neovim buffers without losing window layout
        {
            'famiu/bufdelete.nvim',
            lazy = false,
            cond = is_not_embedded,
        },

        -- Language support
        -- Generic
        -- 🧠 💪 // Smart and powerful comment plugin for neovim. Supports treesitter, dot repeat, left-right/up-down motions, hooks, and more
        {
            'numToStr/Comment.nvim',
            config = require('plugins._comment').config,
            event = 'BufReadPost'
        },

        -- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
        {
            'hedyhli/outline.nvim',
            config = require('plugins._symbols_outline').config,
            event = 'BufReadPost',
            cond = is_not_embedded
        },

        -- Nvim Treesitter configurations and abstraction layer
        {
            'nvim-treesitter/nvim-treesitter',
            run = ':TSUpdate',
            config = require('plugins._treesitter').config,
            version = false,
            event = 'BufReadPost'
        },

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
            event = 'BufReadPost'
        },

        -- Show code context
        {
            'nvim-treesitter/nvim-treesitter-context',
            dependencies = 'nvim-treesitter/nvim-treesitter',
            config = require('plugins._treesitter_context').config,
            event = 'VeryLazy'
        },

        -- Enhanced matchparen.vim plugin for Neovim
        {
            'utilyre/sentiment.nvim',
            version = '*',
            config = require('plugins._sentiment').config,
            event = 'BufReadPost'
        },

        -- LSP and auto completion
        -- Extension to mason.nvim that makes it easier to lspconfig with mason.nvim
        {
            'williamboman/mason-lspconfig.nvim',
            dependencies = { 'williamboman/mason.nvim', { 'neovim/nvim-lspconfig', version = false } },
            config = require('plugins._mason_lspconfig').config,
            event = 'BufEnter',
            cond = is_not_embedded
        },

        {
            'WhoIsSethDaniel/mason-tool-installer.nvim',
            dependencies = { 'williamboman/mason.nvim' },
            config = require('plugins._mason_tool_installer').config,
            event = 'BufEnter',
            cond = is_not_embedded
        },

        -- An unofficial collection of linters and formatters configured for efm-langserver for neovim.
        {
            'creativenull/efmls-configs-nvim',
            dependencies = { 'neovim/nvim-lspconfig', 'williamboman/mason-lspconfig.nvim' },
            config = require('plugins._efm').config,
            event = 'BufEnter'
        },

        -- A completion plugin for neovim coded in Lua.
        {
            'hrsh7th/nvim-cmp',
            config = require('plugins._cmp').config,
            event = { 'InsertEnter', 'CmdlineEnter' },
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
                -- 'nvim-lua/lsp-status.nvim',

                -- A neovim plugin that helps managing crates.io dependencies
                {
                    'saecki/crates.nvim',
                    dependencies = { 'nvim-lua/plenary.nvim' },
                    config = require('plugins._crates').config,
                },
            },
            cond = is_not_embedded
        },

        -- Fully featured & enhanced replacement for copilot.vim complete with API for interacting with Github Copilot
        {
            'zbirenbaum/copilot.lua',
            cmd = 'Copilot',
            config = require('plugins._copilot').config,
            cond = is_not_embedded
        },

        -- Simple Copilot status indicator for Neovim
        {
            'jonahgoldwastaken/copilot-status.nvim',
            dependencies = { 'zbirenbaum/copilot.lua' },
            config = require('plugins._copilot_status').config,
            cond = is_not_embedded
        },

        -- Free, ultrafast Copilot alternative for Vim and Neovim
        {
            'Exafunction/codeium.vim',
            cmd = 'Codeium',
            config = require('plugins._codeium').config,
            init = require('plugins._codeium').setup,
            cond = is_not_embedded
        },

        -- Quickfix
        -- 🚦 A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
        {
            'folke/trouble.nvim',
            config = require('plugins._trouble').config,
            event = 'BufReadPost',
            cond = is_not_embedded
        },

        -- 🌸 A command-line fuzzy finder
        {
            'junegunn/fzf',
            run = function()
                vim.fn['fzf#install']()
            end,
            cond = is_not_embedded
        },

        -- Better quickfix window in Neovim, polish old quickfix window.
        {
            'kevinhwang91/nvim-bqf',
            dependencies = { 'junegunn/fzf', 'nvim-treesitter/nvim-treesitter' },
            ft = 'qf',
            cond = is_not_embedded
        },

        -- C/C++
        -- Clangd's off-spec features for neovim's LSP client
        {
            'p00f/clangd_extensions.nvim',
            config = require('plugins._clangd').config,
            ft = { 'c', 'cpp', 'h', 'hpp' },
            cond = is_not_embedded
        },

        -- C#
        -- Extended 'textDocument/definition' handler for OmniSharp Neovim LSP
        {
            'Hoffs/omnisharp-extended-lsp.nvim',
            ft = 'cs',
            cond = is_not_embedded
        },

        -- Swift (for ShadowVim)
        -- Vim runtime files for Swift
        {
            'keith/swift.vim',
            cond = global.is_in_xcode
        },

        -- Rust
        -- Vim configuration for Rust.
        {
            'rust-lang/rust.vim',
            ft = 'rust',
            cond = is_not_embedded
        },

        -- Tools for better development in rust using neovim's builtin lsp
        {
            'mrcjkb/rustaceanvim',
            version = '^3',
            ft = 'rust',
            config = require('plugins._lsp_rust').config,
            cond = is_not_embedded
        },

        -- Ruby
        -- Vim/Ruby Configuration Files
        {
            'vim-ruby/vim-ruby',
            ft = 'ruby',
            cond = is_not_embedded
        },

        -- Just
        --  Treesitter grammar for Justfiles (casey/just)
        {
            'IndianBoy42/tree-sitter-just',
            dependencies = { 'nvim-treesitter/nvim-treesitter' },
            config = require('plugins._just').config,
            ft = 'just',
            cond = is_not_embedded
        },

        -- HTML/CSS
        -- emmet for vim: http://emmet.io/
        {
            'mattn/emmet-vim',
            ft = { 'html', 'javascriptreact', 'typescriptreact' },
            cond = is_not_embedded
        },

        -- Dart & Flutter
        -- Syntax highlighting for Dart in Vim
        {
            'dart-lang/dart-vim-plugin',
            init = require('plugins._dart').setup,
            ft = 'dart',
            cond = is_not_embedded
        },

        -- Tools to help create flutter apps in neovim using the native lsp
        {
            'akinsho/flutter-tools.nvim',
            dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
            ft = 'dart',
            cond = is_not_embedded
        },

        -- nu-shell
        {
            'LhKipp/nvim-nu',
            dependencies = { 'nvim-treesitter/nvim-treesitter' },
            config = require('plugins._nvim_nu').config,
            ft = 'nu',
            cond = is_not_embedded
        },
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
