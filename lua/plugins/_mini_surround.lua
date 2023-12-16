local M = {}

function M.config()
    require('mini.surround').setup({
        mappings = {
            add = 'coa',            -- Add surrounding in Normal and Visual modes
            delete = 'cod',         -- Delete surrounding
            find = 'cof',           -- Find surrounding (to the right)
            find_left = 'coF',      -- Find surrounding (to the left)
            highlight = 'coh',      -- Highlight surrounding
            replace = 'cor',        -- Replace surrounding
            update_n_lines = 'con', -- Update `n_lines`
        }
    })
end

return M
