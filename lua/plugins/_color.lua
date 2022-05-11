local M = {}

function M.config()
    local onedark = require('onedark')
    onedark.setup {
        style = 'darker'
    }

    onedark.load()
end

return M
