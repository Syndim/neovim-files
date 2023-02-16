local M = {}

function M.config()
    require('telescope').load_extension('frecency')

    local opts = {
        noremap = true
    }
    vim.api.nvim_set_keymap("n", "<A-i>",
        "<Cmd>lua require('telescope').extensions.frecency.frecency({ workspace = 'CWD' })<CR>", opts)
end

return M
