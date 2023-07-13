local M = {}

function M.config()
    require('crates').setup({
        null_ls = {
            enabled = false,
        },
    })
end

return M
