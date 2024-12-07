local M = {}

function M.config()
	require("outline").setup({
		outline_window = {
			position = "left",
			show_numbers = true,
			show_relative_numbers = true,
		},
	})
	vim.keymap.set("n", "<F4>", vim.cmd.Outline, {})
end

return M
