local M = {}

function M.config()
    require('telescope').load_extension('vim_bookmarks')
    local opts = {
        noremap = true
    }

    local api = vim.api;

    api.nvim_set_keymap('n', '<leader>mm', [[<cmd>BookmarkToggle<CR>]], opts)
    api.nvim_set_keymap('n', '<leader>ms', [[<cmd>Telescope vim_bookmarks all<CR>]], opts)
    api.nvim_set_keymap('n', '<leader>mb', [[<cmd>BookmarkPrev<CR>]], opts)
    api.nvim_set_keymap('n', '<leader>mn', [[<cmd>BookmarkNext<CR>]], opts)
end

function M.setup()
    vim.g.bookmark_no_default_key_mappings = 1
end

return M
