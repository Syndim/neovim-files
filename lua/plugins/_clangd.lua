local M = {}

function M.config()
    vim.keymap.set('n', '<Leader>a', vim.cmd.ClangdSwitchSourceHeader,
        { remap = false, desc = 'Switch C/C++ source header' })
end

return M
