local M = {}

function M.config()
	require("avante").setup({
		provider = "copilot",
		auto_suggestions_provider = "copilot",
		file_selector = {
			provider = "telescope",
		},
	})
end

return M
