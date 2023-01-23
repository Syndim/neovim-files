local M = {}

function M.config()
    local opts = {
        noremap = true
    }

    vim.api.nvim_set_keymap('n', '<A-k>', '<cmd>lua require("illuminate").goto_prev_reference()<cr>', opts)
    vim.api.nvim_set_keymap('n', '<A-j>', '<cmd>lua require("illuminate").goto_next_reference()<cr>', opts)
end

return M
