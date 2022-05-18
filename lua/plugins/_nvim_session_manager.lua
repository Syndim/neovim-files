local M = {}

function M.config()
    require('session_manager').setup({
        autoload_mode = require('session_manager.config').AutoloadMode.CurrentDir
    })
end

return M
