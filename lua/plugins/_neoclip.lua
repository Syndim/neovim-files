local M = {}

function M.config()
	require("neoclip").setup({
		keys = {
			telescope = {
				i = {
					paste = "<nop>",
					paste_behind = "<nop>",
				},
			},
		},
	})
	local ts = require("plugins._telescope")
	local opts = { remap = false }
	opts.desc = "Open neoclip"
	vim.keymap.set("n", "<leader>p", function()
		-- require("neoclip.fzf")()
		require("telescope").extensions.neoclip.default(ts.dropdown_theme)
	end, opts)
end

return M
