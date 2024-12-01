local M = {}

function M.config()
	require("dropbar").setup({
		bar = {
			sources = function(buf, _)
				local sources = require("dropbar.sources")
				local utils = require("dropbar.utils")
				local ft = vim.bo[buf].ft
				if ft == "markdown" then
					return {
						sources.path,
						sources.markdown,
					}
				end
				if vim.bo[buf].buftype == "terminal" then
					return {
						sources.terminal,
					}
				end
				return {
					sources.path,
					utils.source.fallback({
						sources.lsp,
						-- sources.treesitter,
					}),
				}
			end,
		},
	})
end

return M
