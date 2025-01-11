local M = {}

function M.config()
	require("render-markdown").setup({
		file_types = { "markdown", "codecompanion", "Avante" },
	})
end

return M
