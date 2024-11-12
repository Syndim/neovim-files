local M = {}

function M.config()
	local ssr = require("ssr")
	ssr.setup({})
	vim.keymap.set({ "n", "x" }, "<leader>S", ssr.open, { noremap = true, desc = "Structure search" })
end

return M
