local M = {}

function M.config()
	require("nvim-tree").setup({
		view = {
			relativenumber = true,
			number = true,
		},
	})

	local opts = {
		remap = false,
	}

	opts.desc = "Toggle file tree"
	vim.keymap.set("", "<F3>", vim.cmd.NvimTreeToggle, opts)
	opts.desc = "Find file in file tree"
	vim.keymap.set("", "<F2>", vim.cmd.NvimTreeFindFile, opts)
end

return M
