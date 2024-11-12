local M = {}

function M.config()
	require("moody").setup({
		disabled_filetypes = {
			"TelescopePrompt",
		},
		blends = {
			visual = 0.5,
		},
	})
end

return M
