local M = {}

function M.config()
	local global = require("global")
	for _, config in pairs(require("nvim-treesitter.parsers").get_parser_configs()) do
		config.install_info.url =
			config.install_info.url:gsub("https://github.com/", global.github_proxy .. "github.com/")
	end

	local proxy = os.getenv("HTTPS_PROXY") or ""
	if proxy then
		require("nvim-treesitter.install").command_extra_args = {
			curl = { "--proxy", proxy },
		}
	end

	local treesitter_path = vim.fn.stdpath("data") .. "/treesitter"
	vim.opt.runtimepath:prepend(treesitter_path)

	require("nvim-treesitter.configs").setup({
		parser_install_dir = treesitter_path,
		highlight = {
			enable = true,
			disable = function(lang, _)
				local enabled_languages = { "python", "fish", "ruby", "javascript", "typescript", "typescriptreact" } -- , 'just' }
				for _, enabled in pairs(enabled_languages) do
					if lang == enabled then
						return false
					end
				end

				return true
			end,
		},
		indent = {
			enable = false,
			disable = {},
		},
		ensure_installed = {
			"cpp",
			"c_sharp",
			"css",
			"dart",
			"java",
			"javascript",
			"json",
			"kotlin",
			"lua",
			"python",
			"regex",
			"ruby",
			"rust",
			"scss",
			"toml",
			"typescript",
			"yaml",
			"fish",
			"vim",
			"slint",
			"html",
			"tsx",
			"vimdoc",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "grn",
				scope_incremental = "grc",
				node_decremental = "grm",
			},
		},
	})

	vim.treesitter.language.register("javascript", "typescript")
	vim.treesitter.language.register("typescriptreact", "typescript")
end

return M
