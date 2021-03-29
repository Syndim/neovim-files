local M = {}

function M.config()
    require('telescope').setup({})

    local cmd = vim.cmd
    cmd('nnoremap <C-p> <cmd>Telescope find_files<cr>')
    cmd('nnoremap <leader>ff <cmd>Telescope find_files<cr>')
    cmd('nnoremap <leader>fg <cmd>Telescope live_grep<cr>')
    cmd('nnoremap <leader>fb <cmd>Telescope buffers<cr>')
    cmd('nnoremap <leader>fh <cmd>Telescope help_tags<cr>')
end

return M
