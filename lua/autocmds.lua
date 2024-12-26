local api = vim.api

-- Fix json indent issue
api.nvim_create_autocmd({ "VimEnter", "BufWinEnter", "BufRead", "BufNewFile", "BufEnter" }, {
	pattern = { "*.arb", "*.json" },
	callback = function()
		vim.cmd("set filetype=json")
		vim.g.indentLine_conceallevel = 0
	end,
})

api.nvim_create_autocmd({ "BufLeave" }, {
	pattern = { "*.arb", "*.json" },
	callback = function()
		vim.g.indentLine_conceallevel = nil
	end,
})

-- Format on save
api.nvim_create_autocmd({ "BufWritePre" }, {
	callback = function(args)
		local features = require("features")
		if features.format_on_save_enabled then
			-- vim.lsp.buf.format()
			require("conform").format({ bufnr = args.buf })
		end
	end,
})

api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
	callback = function()
		vim.bo.tabstop = 2
		vim.bo.shiftwidth = 2
	end,
})

api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.slint" },
	callback = function()
		vim.bo.filetype = "slint"
	end,
})

api.nvim_create_autocmd({ "BufEnter" }, {
	pattern = { "*.md" },
	callback = function()
		vim.bo.conceallevel = 2
	end,
})

api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "*" },
	callback = function()
		if vim.bo.filetype == "objcpp" or vim.bo.filetype == "cpp" then
			vim.bo.commentstring = "// %s"
		end
	end,
})
