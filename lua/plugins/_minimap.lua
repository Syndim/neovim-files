local M = {}

function M.setup()
    local minimap_width = 15
    vim.g.neominimap = {
        float = {
            minimap_width = minimap_width
        },
        split = {
            minimap_width = minimap_width
        },
        click = {
            enabled = true
        }
    }

    vim.o.wrap = false
    vim.o.sidescrolloff = minimap_width + 5
end

return M
