local M = {}

function M.config()
	require("avante").setup({
		provider = "copilot",
		auto_suggestions_provider = "copilot",
	})
end

return M
