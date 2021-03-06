local M = {}

function M.config()
    require('bufferline').setup(
        {
            options = {
                show_buffer_close_icons = false,
                show_close_icon = false,
                left_trunc_marker = '',
                right_trunc_marker = '',
                separator_style = 'thin',
                diagnostics = 'nvim_lsp',
                offsets = {
                    { filetype = "neo-tree", text = "File Explorer", text_align = "left" }
                },
            }
        }
    )
end

return M
