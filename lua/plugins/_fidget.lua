local M = {}

function M.config()
    local fidget = require('fidget')
    fidget.setup()
    vim.notify = fidget.notify
end

return M
