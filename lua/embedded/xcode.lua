if not vim.g.shadowvim then
	return
end

local opts = {
	noremap = true,
}
vim.keymap.set("n", "gd", function()
	vim.cmd.SVPress("<LT>C-D-j>")
end, opts)
vim.keymap.set("n", "gr", function()
	vim.cmd.SVPress("<LT>C-S-D-f>")
end, opts)
vim.keymap.set("n", "K", function()
	vim.cmd.SVPress("<LT>M-LeftMouse>")
end, opts)
vim.keymap.set("n", "<C-o>", function()
	vim.cmd.SVPress("<LT>C-D-Left>")
end, opts)
vim.keymap.set("n", "<C-i>", function()
	vim.cmd.SVPress("<LT>C-D-Right>")
end, opts)
vim.keymap.set("n", "zz", function()
	vim.cmd.SVPress("<LT>C-M-S-D-l>")
end, opts)
