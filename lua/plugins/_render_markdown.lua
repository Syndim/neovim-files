local M = {}

function M.config()
	require("render-markdown").setup({
		file_types = { "markdown", "copilot-chat" },
	})
end

return M
