local M = {}

local codeium_initialized = false

function M.status()
	if codeium_initialized then
		local status = require("codeium.virtual_text").status()
		if status.state == "idle" then
			return "󱃖"
		elseif status.state == "completions" then
			return string.format("%d/%d", status.current, status.total)
		elseif status.state == "waiting" then
			return ""
		else
			return "󱃖"
		end
	end

	return ""
end

function M.config()
	require("codeium").setup({
		enable_cmp_source = false,
		virtual_text = {
			enabled = true,
			key_bindings = {
				accept = "<C-f>",
				next = "<M-]>",
				prev = "<M-[>",
				clear = "<C-]>",
			},
		},
	})
	-- vim.keymap.set("i", "<C-f>", function()
	-- 	return vim.fn["codeium#Accept"]()
	-- end, { expr = true })
	-- vim.keymap.set("i", "<M-]>", function()
	-- 	return vim.fn["codeium#CycleCompletions"](1)
	-- end, { expr = true })
	-- vim.keymap.set("i", "<M-[>", function()
	-- 	return vim.fn["codeium#CycleCompletions"](-1)
	-- end, { expr = true })
	-- vim.keymap.set("i", "<c-]>", function()
	-- 	return vim.fn["codeium#Clear"]()
	-- end, { expr = true })

	codeium_initialized = true
end

return M
