local M = {}

function M.config()
    require("toggleterm").setup{
        size = 14,
        open_mapping = [[<F12>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = '1', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        persist_size = true,
        direction = 'horizontal',
    }
end

return M
