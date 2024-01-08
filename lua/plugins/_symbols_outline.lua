local M = {}

function M.config()
    require('outline').setup({
        outline_window = {
            show_numbers = true,
            show_relative_numbers = true
        }
    })
    vim.api.nvim_set_keymap('n', '<F4>', ':Outline<CR>', { silent = true })
end

return M
