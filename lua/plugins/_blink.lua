local M = {}

function M.config()
	require("blink.cmp").setup({
		keymap = { preset = "enter" },
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
