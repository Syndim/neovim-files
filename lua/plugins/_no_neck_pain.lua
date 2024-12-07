local M = {}

function M.config()
	require("no-neck-pain").setup({
		width = 120,
		integrations = {
			outline = {
				position = "right",
				reopen = true,
			},
		},
	})

	local opts = {
		remap = false,
	}

	opts.desc = "Open Yazi"
	vim.keymap.set("", "<F11>", vim.cmd.NoNeckPain, opts)
end

return M
