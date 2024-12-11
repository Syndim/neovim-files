local function load_plugins(plugins)
	require("lazy").load({
		plugins = plugins,
		show = false,
	})
end

local global = require("global")

local M = {
	format_on_save_enabled = true,
	lsp_config = {},

	is_copilot_enabled = false,
	is_codeium_enabled = false,
	is_xcode_build_enabled = false,

	enable_copilot = function()
		if not global.is_embedded then
			load_plugins({ "copilot.vim" })
			require("features").is_copilot_enabled = true
		end
	end,

	enable_codeium = function()
		if not global.is_embedded then
			load_plugins({ "codeium.vim" })
			require("features").is_codeium_enabled = true
		end
	end,

	enable_xcode_build = function()
		if not global.is_embedded then
			load_plugins({ "xcodebuild.nvim" })
			require("features").is_xcode_build_enabled = true
		end
	end,
}

return M
