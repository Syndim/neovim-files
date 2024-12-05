local M = {}

function M.config()
	require("telescope").load_extension("vim_bookmarks")
	local opts = {
		noremap = true,
	}

	opts.desc = "Toggle bookmark"
	vim.keymap.set("n", "<leader>mm", vim.cmd.BookmarkToggle, opts)
	opts.desc = "List bookmark"
	vim.keymap.set("n", "<leader>ml", function()
		vim.cmd.Telescope({ "vim_bookmarks", "all" })
	end, opts)
	opts.desc = "Previous bookmark"
	vim.keymap.set("n", "<leader>mb", vim.cmd.BookmarkPrev, opts)
	opts.desc = "Next bookmark"
	vim.keymap.set("n", "<leader>mn", vim.cmd.BookmarkNext, opts)
end

function M.setup()
	vim.g.bookmark_no_default_key_mappings = 1
end

return M
