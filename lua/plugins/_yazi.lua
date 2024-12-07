local M = {}

function M.config()
	require("yazi").setup({
		open_for_directories = true,
	})

	local opts = {
		remap = false,
	}

	opts.desc = "Open Yazi"
	vim.keymap.set("", "<F2>", vim.cmd.Yazi, opts)
	opts.desc = "Open Yazi in working directory"
	vim.keymap.set("", "<F3>", function()
		vim.cmd.Yazi("cwd")
	end, opts)
end

return M
