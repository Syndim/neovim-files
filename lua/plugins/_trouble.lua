local M = {}

function M.config()
	require("trouble").setup({})

	local opts = { remap = false }

	-- Lua
	opts.desc = "List diagnostics"
	vim.keymap.set("n", "<leader>tt", function()
		vim.cmd.Trouble()
	end, opts)
	opts.desc = "List workspace diagnostics"
	vim.keymap.set("n", "<leader>wd", function()
		vim.cmd.Trouble("workspace_diagnostics")
	end, opts)
	opts.desc = "List document diagnostics"
	vim.keymap.set("n", "<leader>dd", function()
		vim.cmd.Trouble("document_diagnostics")
	end, opts)
	opts.desc = "List locations"
	vim.keymap.set("n", "<leader>ll", function()
		vim.cmd.Trouble("loclist")
	end, opts)
	opts.desc = "Quick fix"
	vim.keymap.set("n", "<leader>qf", function()
		vim.cmd.Trouble("quickfix")
	end, opts)
end

return M
