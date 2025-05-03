local M = {}

function M.config()
	require("mcphub").setup({
		use_bundled_binary = true,
	})
end

return M
