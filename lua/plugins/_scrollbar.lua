local M = {}

function M.config()
	require("scrollbar").setup()
	require("scrollbar.handlers.search").setup()
end

return M
