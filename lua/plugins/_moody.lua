local M = {}

function M.config()
    require('moody').setup({
        disabled_filetypes = {
            'TelescopePrompt'
        }
    })
end

return M
