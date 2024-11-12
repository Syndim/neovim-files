local M = {}

function M.config()
	require("catppuccin").setup({
		flavour = "mocha",
	})

	vim.cmd.colorscheme("catppuccin")
end

return M
