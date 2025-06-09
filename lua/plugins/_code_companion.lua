local M = {}

function M.config()
	local features = require("features").plugin.code_companion
	local strategies = {
		chat = {
			adapter = "copilot",
		},
		inline = {
			adapter = "copilot",
		},
	}
	local adapters = nil

	if features.strategies then
		strategies = vim.tbl_deep_extend("force", strategies, features.strategies)
	end
	if features.adapters then
		adapters = {}
		for k, v in pairs(features.adapters) do
			adapters[k] = function()
				return require("codecompanion.adapters").extend(k, {
					schema = {
						model = {
							default = v.model,
						},
					},
				})
			end
		end
	end

	require("codecompanion").setup({
		strategies = strategies,
		adapters = adapters,
		display = {
			chat = {
				show_settings = true,
				window = {
					position = "right",
					width = 0.25,
				},
			},
		},
		extensions = {
			mcphub = {
				callback = "mcphub.extensions.codecompanion",
				opts = {
					show_result_in_chat = true,
					make_vars = true,
					make_slash_commands = true,
				},
			},
		},
	})
	vim.keymap.set("n", "<Leader>cc", function()
		vim.cmd.CodeCompanionChat("Toggle")
	end, { remap = false, desc = "Start new code companion chat" })
	vim.keymap.set("v", "<Leader>cc", ":CodeCompanion<CR>", { remap = false, desc = "Explain selected code" })
	vim.keymap.set("v", "<Leader>cex", function()
		vim.cmd.CodeCompanion("/explain")
	end, { remap = false, desc = "Explain selected code" })
	vim.keymap.set("v", "<Leader>clsp", function()
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
