local M = {}

function M.setup()
    vim.g.neominimap = {
        float = {
            minimap_width = 15
        },
        split = {
            minimap_width = 15
        }
    }
end

return M
