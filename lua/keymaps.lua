local opts = {
	remap = false,
}

local global = require("global")

-- Split
-- vim.keymap.set('n', '<Leader>h', vim.cmd.split, opts)
-- vim.keymap.set('n', '<Leader>v', vim.cmd.vsplit, opts)

-- Buffer navigation
vim.keymap.set("n", "<C-left>", "<C-O>", opts)
vim.keymap.set("n", "<C-right>", "<C-I>", opts)
vim.keymap.set("n", "<Leader>b", "<C-O>", opts)
vim.keymap.set("n", "<Leader>n", "<C-I>", opts)

-- Clear CRLF
vim.keymap.set("n", "<Leader>r", "<cmd>%s/\\r//g<CR>", {})

-- Copy/Paste/Cut
vim.keymap.set("n", "YY", '"+y<CR>', opts)
vim.keymap.set("n", "P", '"+gP<CR>', opts)
vim.keymap.set("n", "XX", '"+x<CR>', opts)

-- Vmap for maintain Visual Mode after shifting > and <
vim.keymap.set("v", "<", "<gv", {})
vim.keymap.set("v", ">", ">gv", {})

-- use alt+hjkl to move between split/vsplit panels
vim.keymap.set("t", "<A-h>", "<C-\\><C-n><C-w>h", opts)
vim.keymap.set("t", "<A-j>", "<C-\\><C-n><C-w>j", opts)
vim.keymap.set("t", "<A-k>", "<C-\\><C-n><C-w>k", opts)
vim.keymap.set("t", "<A-l>", "<C-\\><C-n><C-w>l", opts)
vim.keymap.set("t", "<A-w>", "<C-\\><C-n><C-w>w", opts)
vim.keymap.set("n", "<A-h>", "<C-w>h", opts)
vim.keymap.set("n", "<A-j>", "<C-w>j", opts)
vim.keymap.set("n", "<A-k>", "<C-w>k", opts)
vim.keymap.set("n", "<A-l>", "<C-w>l", opts)
vim.keymap.set("n", "<A-w>", "<C-w>w", opts)
vim.keymap.set("n", "<A-->", function()
	local win = vim.api.nvim_get_current_win()
	local wininfo = vim.fn.getwininfo(win)[1]
	if wininfo.width < vim.o.columns then
		vim.cmd("vertical resize -2")
	elseif wininfo.height < vim.o.lines then
		vim.cmd("resize -2")
	end
end, opts)
vim.keymap.set("n", "<A-=>", function()
	local win = vim.api.nvim_get_current_win()
	local wininfo = vim.fn.getwininfo(win)[1]
	if wininfo.width < vim.o.columns then
		vim.cmd("vertical resize +2")
	elseif wininfo.height < vim.o.lines then
		vim.cmd("resize +2")
	end
end, opts)

-- Clear search highlights
opts.desc = "Clear highlights"
vim.keymap.set("n", "<Leader>ch", vim.cmd.noh, opts)

-- Close all buffers
opts.desc = "Close all buffers"
vim.keymap.set("n", "<Leader>X", "<cmd>%bd<CR>", opts)

vim.keymap.set("n", "<C-->", "gcc", { remap = true })
vim.keymap.set("v", "<C-->", "gc", { remap = true })
vim.keymap.set("n", "<C-_>", "gcc", { remap = true })
vim.keymap.set("v", "<C-_>", "gc", { remap = true })

-- Disable LSP keys starts with gr
if vim.fn.has("nvim-0.11") == 1 then
	vim.keymap.del({ "n" }, "grn")
	vim.keymap.del({ "n", "x" }, "gra")
	vim.keymap.del({ "n" }, "gri")
	vim.keymap.del({ "n" }, "grr")
end

local function paste_from_register()
	local content = vim.fn.getreg("+")
	vim.api.nvim_paste(content, false, -1)
end

if global.is_windows or global.is_linux then
	vim.keymap.set("n", "<C-c>", '"+y', opts)
	vim.keymap.set("v", "<C-c>", '"+y', opts)

	vim.keymap.set("n", "<C-v>", '"+gP', opts)
	vim.keymap.set("i", "<C-v>", paste_from_register, opts)
	vim.keymap.set("c", "<C-v>", "<C-r>+", opts)
	vim.keymap.set("v", "<C-v>", '"+gP', opts)
elseif global.is_mac then
	vim.keymap.set("n", "<D-c>", '"+y', opts)
	vim.keymap.set("v", "<D-c>", '"+y', opts)

	vim.keymap.set("n", "<D-v>", '"+gP', opts)
	vim.keymap.set("i", "<D-v>", paste_from_register, opts)
	vim.keymap.set("c", "<D-v>", "<C-r>+", opts)
	vim.keymap.set("v", "<D-v>", '"+gP', opts)
end
