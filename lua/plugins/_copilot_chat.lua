local M = {}

function M.config()
	require("CopilotChat").setup({})

	vim.keymap.set("n", "<Leader>cc", vim.cmd.CopilotChatToggle, { remap = false, desc = "Toggle copilot chat panel" })
end

return M
