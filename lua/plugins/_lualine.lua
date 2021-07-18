local M = {}

function M.config()
    require('lualine').setup({
            options = {
                theme = 'onedark',
                component_separators = '',
                icons_enabled = true
            },
            sections = {
                lualine_a = {
                    { 'mode', upper = true, color = { gui = 'bold' } }
                },
                lualine_b = {
                    { 'branch' },
                    { 'diff', colored = false }
                },
                lualine_c = {
                    { 'filename', path = 1, file_status = true },
                    { 'diagnostics', sources = { 'coc' } },
                    { 'g:coc_status' }
                },
                lualine_x = { { 'filetype', colored = true }, 'encoding', 'fileformat' },
                lualine_y = { 'progress' },
                lualine_z = {
                    { 'location', color = { gui = 'bold' } }
                }
            },
            extensions = { 'quickfix', 'fzf', 'nerdtree' }
        })
end

return M
