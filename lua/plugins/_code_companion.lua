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
					width = 0.35,
				},
			},
		},
	})
	vim.keymap.set("n", "<Leader>cc", function()
		vim.cmd.CodeCompanionChat("Toggle")
	end, { remap = false, desc = "Start new code companion chat" })
	vim.keymap.set("v", "<Leader>cex", function()
		vim.cmd.CodeCompanion("/explain")
	end, { remap = false, desc = "Explain selected code" })
	vim.keymap.set("v", "<Leader>csp", function()
		vim.cmd.CodeCompanion("/lsp")
	end, { remap = false, desc = "Explain LSP diagnostics for selected code" })
	vim.keymap.set("v", "<Leader>csb", function()
		vim.cmd.CodeCompanion("/buffer")
	end, { remap = false, desc = "Send the current buffer to the LLM as part of an inline prompt" })
	vim.keymap.set("v", "<Leader>cfix", function()
		vim.cmd.CodeCompanion("/fix")
	end, { remap = false, desc = "Fix the selected code" })
	vim.keymap.set("v", "<Leader>ct", function()
		vim.cmd.CodeCompanion("/tests")
	end, { remap = false, desc = "Generate unit tests for selected code" })
	vim.keymap.set("n", "<Leader>cgc", function()
		vim.cmd.CodeCompanion("/commit")
	end, { remap = false, desc = "Generate commit message for staged change" })
end

return M
