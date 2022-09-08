local M = {}

function M.config()
    local notify_fn = require('notify')
    vim.notify = function(msg, level, opts)
        if string.len(msg) > 0 then
            notify_fn(msg, level, opts)
        end
    end
end

return M

