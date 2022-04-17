local M = {}

function M.config()
    vim.api.nvim_set_keymap('n', '<Leader>a', ':ClangdSwitchSourceHeader<CR>', { noremap = true })
end

return M
