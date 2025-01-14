local M = {}

function M.config()
	local fzf = require("fzf-lua")
	fzf.setup({
		keymap = {
			builtin = {
				["<C-u>"] = "preview-page-up",
				["<C-d>"] = "preview-page-down",
			},
		},
	})

	local opts = {
		noremap = true,
	}
	opts.desc = "Find files"
	vim.keymap.set("n", "<C-p>", function()
		fzf.files()
	end, opts)
	opts.desc = "Find buffers"
	vim.keymap.set("n", "<Leader>fb", function()
		fzf.buffers()
	end, opts)
	vim.keymap.set("n", "<A-o>", function()
		fzf.buffers()
	end, opts)
	opts.desc = "Git status"
	vim.keymap.set("n", "<Leader>gs", function()
		fzf.git_status()
	end, opts)
	opts.desc = "Git branches"
	vim.keymap.set("n", "<Leader>gb", function()
		fzf.git_branches()
	end, opts)
	opts.desc = "Find keymaps"
	vim.keymap.set("n", "<Leader>km", function()
		fzf.keymaps()
	end, opts)
	opts.desc = "Find commands"
	vim.keymap.set("n", "<Leader>cm", function()
		fzf.commands()
	end, opts)
	vim.keymap.set("n", "<A-p>", function()
		fzf.commands()
	end, opts)
	opts.desc = "Jump list"
	vim.keymap.set("n", "<Leader>jl", function()
		fzf.jumps()
	end, opts)
	vim.keymap.set("n", "<A-i>", function()
		fzf.jumps()
	end, opts)
end

return M
