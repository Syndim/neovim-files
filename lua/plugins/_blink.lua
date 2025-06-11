local M = {}

function M.setup()
	local global = require("global")

	local download = require("blink.cmp.fuzzy.download")

	local function download_file(url, filename)
		local download_config = require("blink.cmp.config").fuzzy.prebuilt_binaries
		local async = require("blink.cmp.lib.async")
		local files = require("blink.cmp.fuzzy.download.files")
		url = string.gsub(url, "https://github.com", global.github.url)
		url = string.gsub(url, "https://raw.githubusercontent.com", global.github.raw_url)
		return async.task.new(function(resolve, reject)
			local args = { "curl" }
			vim.list_extend(args, download_config.extra_curl_args)
			vim.list_extend(args, {
				"--fail", -- Fail on 4xx/5xx
				"--location", -- Follow redirects
				"--silent", -- Don't show progress
				"--show-error", -- Show errors, even though we're using --silent
				"--create-dirs",
				"--output",
				files.lib_folder .. "/" .. filename,
				url,
			})

			vim.system(args, {}, function(out)
				if out.code ~= 0 then
					reject("Failed to download " .. filename .. "for pre-built binaries: " .. out.stderr)
				else
					resolve()
				end
			end)
		end)
	end

	if global.github.has_proxy then
		download.download_file = download_file
	end
end

function M.config()
	local features = require("features")
	require("blink.cmp").setup({
		keymap = {
			preset = "enter",
			["<C-f>"] = {},
			["<C-u>"] = { "scroll_documentation_up", "fallback" },
			["<C-d>"] = { "scroll_documentation_down", "fallback" },
		},
		cmdline = {
			keymap = { preset = "super-tab" },
			completion = {
				menu = {
					auto_show = true,
				},
			},
		},
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		sources = {
			default = function(ctx)
				if vim.bo.filetype == "DressingInput" then
					return {}
				end

				local sources = { "lsp", "buffer", "snippets", "path" }
				if features.plugin.code_companion.enabled then
					table.insert(sources, "codecompanion")
				end
				-- if features.plugin.avante.enabled then
				-- 	table.insert(sources, "avante")
				-- end

				if vim.bo.filetype == "toml" then
					table.insert(sources, "crates")
				elseif vim.bo.filetype == "json" then
					table.insert(sources, "npm")
				elseif vim.bo.filetype == "lua" then
					table.insert(sources, "lazydev")
				end

				return sources
			end,
			providers = {
				lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", fallbacks = { "lsp" } },
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
				-- avante = {
				-- 	module = "blink-cmp-avante",
				-- 	name = "Avante",
				-- },
			},
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			list = {
				selection = {
					auto_insert = true,
					preselect = true,
				},
			},
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
			},
		},
		signature = {
			enabled = true,
		},
	})
end

return M
