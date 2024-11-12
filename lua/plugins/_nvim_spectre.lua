local M = {}

function M.config()
	local opts = {
		remap = false,
	}
	opts.desc = "Open Spectre"
	vim.keymap.set("n", "<leader>s", require("spectre").open, opts)
end

return M
