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
			"ts_ls",
			"vale",
		},
	})

	vim.cmd.MasonToolsInstall()
end

return M
