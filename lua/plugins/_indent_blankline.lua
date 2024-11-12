local M = {}

function M.config()
	require("ibl").setup({
		indent = {
			char = "│",
		},
		exclude = {
			filetypes = { "help", "alpha", "dashboard", "NvimTree", "Trouble", "lazy" },
		},
	})
end

return M
