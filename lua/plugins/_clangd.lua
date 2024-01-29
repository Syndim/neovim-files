local M = {}

function M.config()
    vim.keymap.set('n', '<Leader>a', vim.cmd.ClangdSwitchSourceHeader, { remap = false })
end

return M
