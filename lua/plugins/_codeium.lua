local M = {}

local global = require("global")
local codeium_initialized = false

function M.status()
	if codeium_initialized then
		local status = vim.api.nvim_buf_get_var(0, "_codeium_status")
		if status == nil then
			if vim.fn["codeium#Enabled"]() then
				return "󱃖"
			else
				return ""
			end
		elseif status == 2 then
			local completions = vim.api.nvim_buf_get_var(0, "_codeium_completions")
			if completions["items"] ~= nil and completions["index"] ~= nil then
				return string.format("%d/%d", completions.index + 1, #completions.items)
			end
			return "0"
		elseif status == 1 then
			return ""
		else
			return "󱃖"
		end
	end

	return ""
end

function M.setup()
	vim.g.codeium_disable_bindings = 1
end

function M.config()
	vim.keymap.set("i", "<C-f>", function()
		return vim.fn["codeium#Accept"]()
	end, { expr = true })
	vim.keymap.set("i", "<M-]>", function()
		return vim.fn["codeium#CycleCompletions"](1)
	end, { expr = true })
	vim.keymap.set("i", "<M-[>", function()
		return vim.fn["codeium#CycleCompletions"](-1)
	end, { expr = true })
	vim.keymap.set("i", "<c-]>", function()
		return vim.fn["codeium#Clear"]()
	end, { expr = true })

	codeium_initialized = true
end

return M
