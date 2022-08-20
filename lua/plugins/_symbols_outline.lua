local M = {}

function M.config()
    require('symbols-outline').setup({})
    vim.api.nvim_set_keymap('n', '<F4>', ':SymbolsOutline<CR>', { silent = true })
end

return M