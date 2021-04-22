local M = {}

function M.config()
    require("toggleterm").setup{
        size = 20,
        open_mapping = [[<F12>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = '<number>', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        persist_size = true,
        direction = 'float',
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
            -- The border key is *almost* the same as 'nvim_win_open'
            -- see :h nvim_win_open for details on borders however
            -- the 'curved' border is a custom border type
            -- not natively supported but implemented in this plugin.
            border = 'single',
            winblend = 3,
            highlights = {
                border = "Normal",
                background = "Normal",
            }
        }
    }
end

return M
