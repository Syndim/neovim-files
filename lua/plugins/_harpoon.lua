local M = {}

function M.config()
    require("harpoon").setup({})
    require("telescope").load_extension('harpoon')
    local api = vim.api

    local opts = {
        noremap = true
    }

    api.nvim_set_keymap('n', '<leader>ma', [[<cmd>lua require("harpoon.mark").add_file()<CR>]], opts)
    -- api.nvim_set_keymap('n', '<leader>ms', [[<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>]], opts)
    api.nvim_set_keymap('n', '<leader>ms', [[<cmd>Telescope harpoon marks<CR>]], opts)
    api.nvim_set_keymap('n', '<leader>mb', [[<cmd>lua require("harpoon.ui").nav_prev()<CR>]], opts)
    api.nvim_set_keymap('n', '<leader>mn', [[<cmd>lua require("harpoon.ui").nav_next()<CR>]], opts)
end

return M
