local M = {}

function M.setup()
    vim.api.nvim_set_keymap('n', '<F4>', ':TagbarToggle<CR>', { silent = true })
end

return M
