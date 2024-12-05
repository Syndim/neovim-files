local M = {}

function M.setup()
	local download = require("blink.cmp.fuzzy.download")
	local github_proxy = require("global").github_proxy

	local download_from_github = function(tag, cb)
		download.get_system_triple(function(system_triple)
			if not system_triple then
				return cb(
					"Your system is not supported by pre-built binaries. You must run cargo build --release via your package manager with rust nightly. See the README for more info."
				)
			end

			local url = github_proxy
				.. "github.com/saghen/blink.cmp/releases/download/"
				.. tag
				.. "/"
				.. system_triple
				.. download.get_lib_extension()

			vim.system({
				"curl",
				"--fail", -- Fail on 4xx/5xx
				"--location", -- Follow redirects
				"--silent", -- Don't show progress
				"--show-error", -- Show errors, even though we're using --silent
				"--create-dirs",
				"--output",
				download.lib_path,
				url,
			}, {}, function(out)
				if out.code ~= 0 then
					return cb("Failed to download pre-build binaries: " .. out.stderr)
				end
				cb()
			end)
		end)
	end

	if github_proxy ~= nil and github_proxy ~= "" then
		download.from_github = download_from_github
	end
end

function M.config()
	require("blink.cmp").setup({
		keymap = {
			preset = "enter",
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		sources = {
			completion = {
				enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev", "crates", "npm" },
			},
			providers = {
				lsp = { fallback_for = { "lazydev" } },
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
				crates = {
					name = "crates",
					module = "blink.compat.source",
					score_offset = -3,
				},
				npm = {
					name = "npm",
					module = "blink.compat.source",
					score_offset = -3,
				},
			},
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			documentation = {
				auto_show = true,
			},
		},
		signature = {
			enabled = true,
			trigger = {
				show_on_insert_or_trigger_character = true,
			},
		},
	})
end

return M
