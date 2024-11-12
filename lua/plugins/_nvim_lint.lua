local M = {}

function M.config()
	local lint = require("lint")
	lint.linters_by_ft = {
		markdown = { "vale" },
		fish = { "fish" },
		lua = { "luac" },
	}

	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		callback = function()
			lint.try_lint()
		end,
	})
end

return M
