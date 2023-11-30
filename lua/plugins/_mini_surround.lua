local M = {}

function M.config()
    require('mini.surround').setup({
        mappings = {
            add = 'cua',            -- Add surrounding in Normal and Visual modes
            delete = 'cud',         -- Delete surrounding
            find = 'cuf',           -- Find surrounding (to the right)
            find_left = 'cuF',      -- Find surrounding (to the left)
            highlight = 'cuh',      -- Highlight surrounding
            replace = 'cur',        -- Replace surrounding
            update_n_lines = 'cun', -- Update `n_lines`
        }
    })
end

return M
