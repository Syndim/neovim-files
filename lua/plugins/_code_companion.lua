local M = {}

function M.config()
	require("codecompanion").setup({
		strategies = {
			chat = {
				adapter = "copilot",
			},
			inline = {
				adapter = "copilot",
			},
		},
		display = {
			chat = {
				window = {
					position = "right",
					width = 0.4,
				},
			},
		},
	})
	vim.keymap.set("n", "<Leader>cc", function()
		vim.cmd.CodeCompanionChat("Toggle")
	end, { remap = false, desc = "Start new code companion chat" })
end

return M
