local M = {}

function M.config()
    require('copilot').setup({
        panel = {
            auto_refresh = true
        },
        suggestion = {
            auto_trigger = true,
        }
    })
end

return M
