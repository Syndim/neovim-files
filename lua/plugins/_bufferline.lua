local M = {}

function M.config()
    require('bufferline').setup(
        {
            options = {
                show_buffer_close_icons = false,
                show_close_icon = false,
                show_tab_indicators = false,
                left_trunc_marker = '',
                right_trunc_marker = '',
                separator_style = 'thin'
            }
        }
    )
end

return M
