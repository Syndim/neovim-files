local M = {}

function M.config()
    require('indent_blankline').setup({
        char = '│',
        filetype_exclude = { 'help', 'alpha', 'dashboard', 'neo-tree', 'Trouble', 'lazy' },
        show_trailing_blankline_indent = false,
        show_current_context = false,
    })
end

return M
