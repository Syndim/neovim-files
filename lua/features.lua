local function load_plugins(plugins)
	require("lazy").load({
		plugins = plugins,
		show = false,
	})
end

local global = require("global")

local M = {
	lsp_config = {},
	enable_format_on_save = true,
	enable_copilot = false,
	enable_code_companion = false,
	enable_avante = false,
	enable_codeium = false,
	enable_xcode_build = false,
}

function M.setup(opts)
	local config = vim.tbl_deep_extend("force", M, opts)

	if not global.is_embedded then
		if config.enable_avante then
			load_plugins({ "copilot.lua", "avante.nvim" })
		end

		if config.enable_code_companion then
			load_plugins({ "copilot.lua", "codecompanion.nvim" })
		end

		if config.enable_copilot then
			load_plugins({ "copilot.lua" })
		end

		if config.enable_codeium then
			load_plugins({ "codeium.nvim" })
		end

		if config.enable_xcode_build then
			load_plugins({ "xcodebuild.nvim" })
		end
	else
		config.enable_code_companion = false
		config.enable_avante = false
		config.enable_codeium = false
		config.enable_copilot = false
		config.enable_xcode_build = false
	end

	for k, v in pairs(config) do
		M[k] = v
	end
end

return M
