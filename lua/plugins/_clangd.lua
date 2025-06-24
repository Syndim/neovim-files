local M = {}

function M.config()
    vim.api.nvim_create_user_command("A", function()
        vim.cmd.ClangdSwitchSourceHeader()
    end, { nargs = 0 })
end

return M
