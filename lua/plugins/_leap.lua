local M = {}

function M.config()
    require('leap').add_default_mappings()

    vim.keymap.set({ 'n', 'x', 'o' }, 'ss', '<Plug>(leap-forward-to)')
end

return M
