local M = {}

function M.config()
	require("conform").setup({
		formatters_by_ft = {
			lua = { "stylua" },
			python = function(bufnr)
				if require("conform").get_formatter_info("ruff_format", bufnr).available then
					return { "ruff_format" }
				else
					return { "isort", "black" }
				end
			end,
			rust = { "rustfmt", lsp_format = "fallback" },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			cpp = { "clang_format" },
			cs = { "csharpier" },
			just = { "just" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
	})
end

return M
