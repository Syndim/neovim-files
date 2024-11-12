local M = {}

function M.setup()
	vim.g.copilot_no_tab_map = true
end

function M.config()
	local opts = { expr = true, replace_keycodes = false }
	opts.desc = "Accept copilot suggestion"
	vim.keymap.set("i", "<C-f>", function()
		return vim.fn["copilot#Accept"]("\\<CR>")
	end, opts)
end

return M
