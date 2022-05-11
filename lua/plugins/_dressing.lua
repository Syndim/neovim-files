local M = {}

function M.config()
    require('dressing').setup({
        select = {
            enabled = false
        }
    })
end

return M
