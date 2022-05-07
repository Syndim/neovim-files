local M = {}

function M.config()
    require('telescope').load_extension('live_grep_raw')

    vim.api.nvim_set_keymap('n', '<leader>rg', '<cmd>lua require("telescope").extensions.live_grep_raw.live_grep_raw()<CR>', { noremap = true })
end

return M
