local M = {}

function M.config()
	require("mcphub").setup({
		use_bundled_binary = true,
		-- extentions = {
		-- 	avante = {
		-- 		make_slash_commands = true,
		-- 	},
		-- },
	})
end

return M
