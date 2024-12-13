local M = {}

function M.config()
	local Snacks = require("snacks")
	Snacks.setup({
		bigfile = { enabled = true },
		notifier = { enabled = true, style = "fancy" },
		quickfile = { enabled = true },
		statuscolumn = { enabled = true },
		words = { enabled = true },
		indent = { enabled = true },
		scope = { enabled = true },
	})

	local options = { noremap = true, nowait = true, desc = "Close buffer" }
	vim.keymap.set("n", "<Leader>x", function()
		Snacks.bufdelete()
	end, options)
	options.desc = "Blame line"
	vim.keymap.set("n", "<Leader>gB", function()
		Snacks.git.blame_line()
	end, options)
	options.desc = "Lazygit Current File History"
	vim.keymap.set("n", "<Leader>gf", function()
		Snacks.lazygit.log_file()
	end, options)
	options.desc = "Lazygit Log (cwd)"
	vim.keymap.set("n", "<Leader>gl", function()
		Snacks.lazygit.log()
	end, options)
	options.desc = "Rename File"
	vim.keymap.set("n", "<Leader>cr", function()
		Snacks.rename.rename_file()
	end, options)
	options.desc = "Toggle terminal"
	vim.keymap.set("", "<F12>", function()
		Snacks.terminal.toggle()
	end)
	vim.api.nvim_create_user_command("Notifications", function()
		Snacks.notifier.show_history({})
	end, { nargs = 0 })
end

return M
