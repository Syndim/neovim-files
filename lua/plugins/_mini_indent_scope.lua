local M = {}

function M.config()
	vim.api.nvim_create_autocmd("FileType", {
		pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
		callback = function()
			vim.b.miniindentscope_disable = true
		end,
	})
	local opts = {
		symbol = "│",
		options = { try_as_border = true },
	}

	require("mini.indentscope").setup(opts)
end

return M
