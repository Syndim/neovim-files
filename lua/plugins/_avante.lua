local M = {}

function M.config()
	require("avante").setup({
		provider = "copilot",
		auto_suggestions_provider = "copilot",
		file_selector = {
			provider = "telescope",
		},
		windows = {
			width = 40,
		},
	})

	-- TODO: Remove this hack after this PR https://github.com/yetone/avante.nvim/pull/864
	local registry = require("blink.compat.registry")
	local original_registre_source = registry.register_source
	function registry.register_source(name, s)
		if string.find(name, "avante_", 1, true) then
			function s:is_available()
				return vim.bo.filetype == "AvanteInput"
			end
		end

		original_registre_source(name, s)
	end
end

return M
