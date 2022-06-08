local M = {}

function M.config()
    require('telescope').load_extension('live_grep_args')

    vim.api.nvim_set_keymap('n', '<leader>rg', '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>', { noremap = true })
end

return M
