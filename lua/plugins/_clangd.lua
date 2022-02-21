local M = {}

function M.config()
    vim.cmd([[noremap <Leader>a :ClangdSwitchSourceHeader<CR>]])
end

return M
