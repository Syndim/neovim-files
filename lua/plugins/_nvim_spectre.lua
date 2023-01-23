local M = {}

function M.config()
    local opts = {
        noremap = true
    }
    vim.api.nvim_set_keymap('n', '<leader>s', '<cmd>lua require("spectre").open()<CR>', opts)
end

return M
