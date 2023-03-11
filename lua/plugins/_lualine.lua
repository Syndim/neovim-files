local M = {}

function M.config()
    require('lualine').setup({
        options = {
            theme = 'vscode',
            component_separators = '',
            icons_enabled = true
        },
        sections = {
            lualine_a = {
                { 'mode', upper = true, color = { gui = 'bold' } }
            },
            lualine_b = {
                { 'branch' },
                { 'diff',  colored = false }
            },
            lualine_c = {
                { 'filename', path = 1, file_status = true },
                "require'lsp-status'.status()"
                -- { 'diagnostics', sources = { 'nvim_lsp' } },
            },
            lualine_x = { { 'filetype', colored = true }, 'encoding', 'fileformat' },
            lualine_y = { 'progress' },
            lualine_z = {
                { 'location', color = { gui = 'bold' } }
            }
        },
        extensions = { 'quickfix', 'fzf', 'nvim-tree' }
    })
end

return M
