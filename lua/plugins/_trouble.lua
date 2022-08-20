local M = {}

function M.config()
    require('trouble').setup({})

    -- Lua
    vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>Trouble<cr>',
        {silent = true, noremap = true}
    )
    vim.api.nvim_set_keymap('n', '<leader>wd', '<cmd>Trouble workspace_diagnostics<cr>',
        {silent = true, noremap = true}
    )
    vim.api.nvim_set_keymap('n', '<leader>dd', '<cmd>Trouble document_diagnostics<cr>',
        {silent = true, noremap = true}
    )
    vim.api.nvim_set_keymap('n', '<leader>ll', '<cmd>Trouble loclist<cr>',
        {silent = true, noremap = true}
    )
    vim.api.nvim_set_keymap('n', '<leader>qf', '<cmd>Trouble quickfix<cr>',
        {silent = true, noremap = true}
    )
    -- vim.api.nvim_set_keymap('n', 'gR', '<cmd>Trouble lsp_references<cr>',
    --     {silent = true, noremap = true}
    -- )
end

return M