local M = {}

function M.config()
    require('hardtime').setup({
        disabled_filetypes = { 'qf', 'netrw', 'NvimTree', 'lazy', 'mason', 'neo-tree', 'neo-tree-popup' },
    })
end

return M
