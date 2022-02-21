local M = {}

function M.setup()
    vim.cmd('nmap <silent> <F4> :TagbarToggle<CR>')
end

return M
