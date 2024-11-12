local M = {}

function M.config()
	require("mason-tool-installer").setup({
		ensure_installed = {
			"prettierd",
			"yamlfmt",
			"rust-analyzer",
			"roslyn",
			"stylua",
			"csharpier",
		},
	})

	vim.cmd.MasonToolsInstall()
end

return M
