local M = {}

function M.config()
	vim.api.nvim_create_user_command("A", vim.cmd.ClangdSwitchSourceHeader, { nargs = 0 })
end

return M
