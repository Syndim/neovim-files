local M = {}

function M.config()
	local opts = {
		remap = false,
	}
	opts.desc = "Open Spectre"
	vim.keymap.set("n", "<leader>s", require("spectre").open, opts)
	vim.api.nvim_create_user_command("SpectreClose", require("spectre").close, { nargs = 0 })
end

return M
