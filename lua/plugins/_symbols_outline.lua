local M = {}

function M.config()
    require('symbols-outline').setup({
        show_numbers = true,
        show_relative_numbers = true
    })
    vim.api.nvim_set_keymap('n', '<F4>', ':SymbolsOutline<CR>', { silent = true })
end

return M

