local api = vim.api

api.nvim_create_autocmd({ 'VimEnter', 'BufWinEnter', 'BufRead', 'BufNewFile', 'BufEnter' }, { pattern = { '*.arb', '*.json' }, callback = function()
    vim.cmd([[set filetype=json]])
    vim.g.indentLine_conceallevel = 0
end })
api.nvim_create_autocmd({ 'BufLeave' }, { pattern = { '*.arb', '*.json' }, callback = function()
    vim.g.indentLine_conceallevel = nil
end })
