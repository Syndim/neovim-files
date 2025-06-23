---@diagnostic disable: missing-fields
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local global = require("global")

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		global.github.url .. "/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

local is_not_embedded = not global.is_embedded

require("lazy").setup({
	-- Package menagement
	-- 💤 A modern plugin manager for Neovim
	"folke/lazy.nvim",

	-- Utils
	-- 🍿 A collection of small QoL plugins for Neovim
	{
		"folke/snacks.nvim",
		lazy = false,
		priority = 1000,
		config = require("plugins._snacks").config,
		cond = is_not_embedded,
	},

	-- Library of 40+ independent Lua modules improving overall Neovim (version 0.8 and higher) experience with minimal effort
	{
		"echasnovski/mini.nvim",
		version = "*",
		event = "VeryLazy",
		config = require("plugins._mini").config,
		cond = is_not_embedded,
	},

	-- Editor interface
	-- Open files and command output from neovim terminals in your current neovim instance
	{
		"willothy/flatten.nvim",
		-- config = true,
		-- or pass configuration with
		opts = {},
		-- Ensure that it runs first to minimize delay when opening file from terminal
		lazy = false,
		priority = 1001,
		cond = is_not_embedded,
	},

	-- A plugin for neovim which changes the colour of CursorColumn depending on mode.
	{
		"svampkorg/moody.nvim",
		event = { "ModeChanged", "BufWinEnter", "WinEnter" },
		config = require("plugins._moody").config,
		cond = is_not_embedded,
	},

	--  Send buffers into early retirement by automatically closing them after x minutes of inactivity.
	{
		"chrisgrieser/nvim-early-retirement",
		config = true,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- A Neovim plugin hiding your colorcolumn when unneeded.
	{
		"m4xshen/smartcolumn.nvim",
		event = "VeryLazy",
		opts = {},
		cond = is_not_embedded,
	},

	-- ✅ Highlight, list and search todo comments in your projects
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		event = "VeryLazy",
		config = require("plugins._todo_comments").config,
		cond = is_not_embedded,
	},

	-- Extensible UI for Neovim notifications and LSP progress messages.
	{
		"j-hui/fidget.nvim",
		config = require("plugins._fidget").config,
		event = { "BufReadPost", "BufNewFile" },
		cond = is_not_embedded,
	},

	-- 💥 Create key bindings that stick. WhichKey is a lua plugin for Neovim 0.5 that displays a popup with possible keybindings of the command you started typing.
	{
		"folke/which-key.nvim",
		config = require("plugins._which_key").config,
		lazy = false,
		cond = is_not_embedded,
	},

	--  Extensible Neovim Scrollbar
	{
		"petertriho/nvim-scrollbar",
		config = require("plugins._scrollbar").config,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- Clipboard manager neovim plugin with telescope integration
	{
		"AckslD/nvim-neoclip.lua",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"kkharji/sqlite.lua",
		},
		config = require("plugins._neoclip").config,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- A snazzy bufferline for Neovim
	{
		"akinsho/bufferline.nvim",
		dependencies = "kyazdani42/nvim-web-devicons",
		version = false,
		config = require("plugins._bufferline").config,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- A blazing fast and easy to configure neovim statusline written in pure lua.
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			{ "kyazdani42/nvim-web-devicons", opt = true },
		},
		config = require("plugins._lualine").config,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- 🍨 Soothing pastel theme for (Neo)vim
	{
		"catppuccin/nvim",
		name = "catppuccin",
		config = require("plugins._color").config,
		priority = 1000,
		lazy = false,
		-- cond = is_not_embedded
	},

	-- A small automated session manager for Neovim
	{
		"rmagatti/auto-session",
		dependencies = "nvim-lua/plenary.nvim",
		config = require("plugins._auto_session").config,
		event = "BufEnter",
		cond = is_not_embedded,
	},

	-- Peek lines just when you intend
	{
		"nacro90/numb.nvim",
		config = require("plugins._numb").config,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	--  Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
	-- {
	-- 	"chrisgrieser/nvim-spider",
	-- 	keys = {
	-- 		{ "w", "<cmd>lua require('spider').motion('w')<CR>", mode = { "n", "o", "x" } },
	-- 		{ "e", "<cmd>lua require('spider').motion('e')<CR>", mode = { "n", "o", "x" } },
	-- 		{ "b", "<cmd>lua require('spider').motion('b')<CR>", mode = { "n", "o", "x" } },
	-- 	},
	-- },

	-- Navigate your code with search labels, enhanced character motions and Treesitter integration
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		config = require("plugins._flash").config,
		keys = {
			{
				"s<CR>",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump({ continue = true })
				end,
				desc = "Flash",
			},
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},

	-- Multiple cursors plugin for vim/neovim
	{
		"mg979/vim-visual-multi",
		branch = "master",
		config = require("plugins._vim_visual_multi").config,
		init = require("plugins._vim_visual_multi").setup,
		event = "VeryLazy",
	},

	-- Hover plugin framework for Neovim
	{
		"lewis6991/hover.nvim",
		config = require("plugins._hover").config,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- Git integration for buffers
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		tag = "release",
		config = require("plugins._gitsigns").config,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- A plugin to visualise and resolve merge conflicts in neovim
	{
		"akinsho/git-conflict.nvim",
		config = true,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- Treesitter based structural search and replace plugin for Neovim.
	{
		"cshuaimin/ssr.nvim",
		config = require("plugins._ssr").config,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- Improved fzf.vim written in lua
	-- {
	-- 	"ibhagwan/fzf-lua",
	-- 	config = require("plugins._fzf").config,
	-- 	event = "VeryLazy",
	-- 	cond = is_not_embedded,
	-- },

	-- Find, Filter, Preview, Pick. All lua, all the time.
	{
		"nvim-telescope/telescope.nvim",
		config = require("plugins._telescope").config,
		event = "VeryLazy",
		-- TODO: Use proper version once telescope releases a new version
		version = false,
		cond = is_not_embedded,
	},

	-- It sets vim.ui.select to telescope. That means for example that neovim core stuff can fill the telescope picker. Example would be lua vim.lsp.buf.code_action().
	{
		"nvim-telescope/telescope-ui-select.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		config = require("plugins._telescope_ui_select").config,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- Find the enemy and replace them with dark power.
	{
		"windwp/nvim-spectre",
		keys = {
			{ "<leader>s" },
		},
		config = require("plugins._nvim_spectre").config,
		cond = is_not_embedded,
	},

	-- Language support
	-- Generic
	-- A tree like view for symbols in Neovim using the Language Server Protocol. Supports all your favourite languages.
	{
		"hedyhli/outline.nvim",
		config = require("plugins._outline").config,
		event = { "VeryLazy" },
		cond = is_not_embedded,
	},

	-- Nvim Treesitter configurations and abstraction layer
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = require("plugins._treesitter").config,
		version = false,
		event = "VeryLazy",
	},

	-- treesitter to auto close and auto rename html tag
	{
		"windwp/nvim-ts-autotag",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = require("plugins._treesitter_autotag").config,
		ft = { "html", "javascriptreact", "typescriptreact" },
	},

	-- autopairs for neovim written by lua
	{
		"windwp/nvim-autopairs",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = require("plugins._treesitter_autopair").config,
		event = "VeryLazy",
	},

	-- LSP and auto completion
	-- Extension to mason.nvim that makes it easier to lspconfig with mason.nvim
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			{ "neovim/nvim-lspconfig", version = false },
			{ "aznhe21/actions-preview.nvim" },
		},
		config = require("plugins._mason_lspconfig").config,
		event = { "BufReadPost", "BufNewFile" },
		cond = is_not_embedded,
	},

	-- Install and upgrade third party tools automatically
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim", "williamboman/mason-lspconfig.nvim" },
		config = require("plugins._mason_tool_installer").config,
		event = { "BufReadPost", "BufNewFile" },
		cond = is_not_embedded,
	},

	-- A panel to view the logs from your LSP servers.
	{
		"mhanberg/output-panel.nvim",
		event = "VeryLazy",
		opts = {},
		cond = is_not_embedded,
	},

	-- Display references, definitions and implementations of document symbols
	{
		"Wansmer/symbol-usage.nvim",
		event = "LspAttach",
		opts = {},
		cond = is_not_embedded,
	},

	-- Lightweight yet powerful formatter plugin for Neovim
	{
		"stevearc/conform.nvim",
		config = require("plugins._conform").config,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- An asynchronous linter plugin for Neovim complementary to the built-in Language Server Protocol support.
	{
		"mfussenegger/nvim-lint",
		config = require("plugins._nvim_lint").config,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- Faster LuaLS setup for Neovim
	{
		"folke/lazydev.nvim",
		ft = "lua",
		config = require("plugins._lazydev").config,
		dependencies = {
			"Bilal2453/luvit-meta",
		},
		cond = is_not_embedded,
	},

	-- performant, batteries-included completion plugin for neovim
	{
		"saghen/blink.cmp",
		lazy = false,
		init = require("plugins._blink").setup,
		config = require("plugins._blink").config,
		dependencies = {
			"rafamadriz/friendly-snippets",
			-- Compatibility layer for using nvim-cmp sources on blink.cmp
			{
				"saghen/blink.compat",
				lazy = true,
				opts = {},
				cond = is_not_embedded,
			},
			-- a neovim plugin that helps managing crates.io dependencies
			{
				"saecki/crates.nvim",
				dependencies = { "nvim-lua/plenary.nvim" },
				config = require("plugins._crates").config,
				ft = "toml",
			},
			--  an additional source for nvim-cmp to autocomplete packages and its versions
			{
				"syndim/cmp-npm",
				branch = "windows_fix",
				config = function()
					require("cmp-npm").setup({})
				end,
				ft = "json",
			},
		},
		cond = is_not_embedded,
	},

	-- IDE-like breadcrumbs, out of the box
	{
		"Bekaboo/dropbar.nvim",
		dependencies = {
			"nvim-telescope/telescope-fzf-native.nvim",
		},
		event = "VeryLazy",
		config = require("plugins._dropbar").config,
		cond = is_not_embedded,
	},

	-- Neovim plugin for GitHub Copilot
	{
		"zbirenbaum/copilot.lua",
		config = require("plugins._copilot").config,
		cond = is_not_embedded,
	},

	{
		"ravitemer/mcphub.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
		},
		-- uncomment the following line to load hub lazily
		--cmd = "MCPHub",  -- lazy load
		build = "bundled_build.lua",
		config = require("plugins._mcphub").config,
		cond = is_not_embedded,
	},

	-- ✨ AI-powered coding, seamlessly in Neovim
	{
		"olimorris/codecompanion.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", version = false },
			"nvim-treesitter/nvim-treesitter",
			"zbirenbaum/copilot.lua",
			"ravitemer/mcphub.nvim",
			"j-hui/fidget.nvim",
		},
		config = require("plugins._code_companion").config,
		cond = is_not_embedded,
	},

	-- Use your Neovim like using Cursor AI IDE!
	-- {
	-- 	"yetone/avante.nvim",
	-- 	version = false,
	-- 	build = global.is_windows and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource true"
	-- 		or "make BUILD_FROM_SOURCE=true CC=clang",
	-- 	dependencies = {
	-- 		"stevearc/dressing.nvim",
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 		"Kaiser-Yang/blink-cmp-avante",
	-- 		"ravitemer/mcphub.nvim",
	-- 	},
	-- 	config = require("plugins._avante").config,
	-- 	cond = is_not_embedded,
	-- },

	--  Plugin to improve viewing Markdown files in Neovim
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = { "markdown", "codecompanion", "Avante" },
		config = require("plugins._render_markdown").config,
		cond = is_not_embedded,
	},

	-- Free, ultrafast Copilot alternative for Vim and Neovim
	{
		"Exafunction/codeium.nvim",
		cmd = "Codeium",
		config = require("plugins._codeium").config,
		cond = is_not_embedded,
	},

	-- Quickfix
	-- 🚦 A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
	{
		"folke/trouble.nvim",
		config = require("plugins._trouble").config,
		event = "VeryLazy",
		cond = is_not_embedded,
	},

	-- Improved UI and workflow for the Neovim quickfix
	{
		"stevearc/quicker.nvim",
		config = require("plugins._quicker").config,
		event = "VeryLazy",
		conf = is_not_embedded,
	},

	-- 🌸 A command-line fuzzy finder
	{
		"junegunn/fzf",
		run = function()
			vim.fn["fzf#install"]()
		end,
		cond = is_not_embedded,
	},

	-- Better quickfix window in Neovim, polish old quickfix window.
	{
		"kevinhwang91/nvim-bqf",
		dependencies = { "junegunn/fzf", "nvim-treesitter/nvim-treesitter" },
		ft = "qf",
		cond = is_not_embedded,
	},

	-- C/C++
	-- Clangd's off-spec features for neovim's LSP client
	{
		"p00f/clangd_extensions.nvim",
		config = require("plugins._clangd").config,
		ft = { "c", "cpp", "h", "hpp" },
		cond = is_not_embedded,
	},

	-- C++ Helper Snippets Using Treesitter
	{
		"Badhi/nvim-treesitter-cpp-tools",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = require("plugins._cpp_tools").config,
		ft = { "c", "cpp", "h", "hpp" },
		cond = is_not_embedded,
	},

	-- C#
	-- Roslyn LSP plugin for neovim
	{
		"seblj/roslyn.nvim",
		dependencies = { "williamboman/mason-lspconfig.nvim" },
		config = require("plugins._roslyn").config,
		ft = { "cs" },
		cond = is_not_embedded,
	},

	-- Swift (for ShadowVim)
	-- Vim runtime files for Swift
	{
		"keith/swift.vim",
		cond = global.is_in_xcode,
	},

	-- Neovim plugin to Build, Debug, and Test iOS & macOS applications.
	{
		"wojciech-kulik/xcodebuild.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"MunifTanjim/nui.nvim",
		},
		config = require("plugins._xcode_build").config,
	},

	-- Typescript
	-- ⚡ TypeScript integration NeoVim deserves ⚡
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		config = require("plugins._lsp_typescript").config,
		ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
		cond = is_not_embedded,
	},

	-- Rust
	-- Vim configuration for Rust.
	{
		"rust-lang/rust.vim",
		ft = "rust",
		cond = is_not_embedded,
	},

	-- Tools for better development in rust using neovim's builtin lsp
	{
		"mrcjkb/rustaceanvim",
		ft = "rust",
		config = require("plugins._lsp_rust").config,
		cond = is_not_embedded,
	},

	-- Ruby
	-- Vim/Ruby Configuration Files
	{
		"vim-ruby/vim-ruby",
		ft = "ruby",
		cond = is_not_embedded,
	},

	-- HTML/CSS
	-- emmet for vim: http://emmet.io/
	{
		"mattn/emmet-vim",
		ft = { "html", "javascriptreact", "typescriptreact" },
		cond = is_not_embedded,
	},

	-- Dart & Flutter
	-- Syntax highlighting for Dart in Vim
	{
		"dart-lang/dart-vim-plugin",
		init = require("plugins._dart").setup,
		ft = "dart",
		cond = is_not_embedded,
	},

	-- Tools to help create flutter apps in neovim using the native lsp
	{
		"nvim-flutter/flutter-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = require("plugins._lsp_flutter").config,
		ft = "dart",
		cond = is_not_embedded,
	},

	-- A neovim clone of pubspec-assist a plugin for adding and updating dart dependencies in pubspec.yaml files.
	{
		"akinsho/pubspec-assist.nvim",
		dependencies = { "plenary.nvim" },
		ft = "yaml",
		opts = {},
		cond = is_not_embedded,
	},

	-- nu-shell
	{
		"LhKipp/nvim-nu",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = require("plugins._nvim_nu").config,
		ft = "nu",
		cond = is_not_embedded,
	},
}, {
	defaults = {
		lazy = true,
		version = "*",
	},
	git = {
		timeout = 600,
	},
	rocks = {
		enabled = false,
	},
})
