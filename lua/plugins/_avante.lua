local M = {}

function M.config()
	local features = require("features")
	local avante_config = features.plugin.avante
	local provider = avante_config.provider
	require("avante").setup({
		provider = provider and provider or "copilot",
		-- auto_suggestions_provider = "copilot",
		file_selector = {
			provider = "telescope",
		},
		windows = {
			width = 35,
		},
		openai = avante_config.openai,
		azure = avante_config.azure,
		claude = avante_config.claude,
	})
end

return M
