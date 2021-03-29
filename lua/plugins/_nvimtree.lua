local M = {}

function M.config()
    local cmd = vim.cmd
    cmd('noremap <F2> :NvimTreeFindFile<CR>')
    cmd('noremap <F3> :NvimTreeToggle<CR>')
end

return M
