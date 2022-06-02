local M = {}

function M.setup(config)
    require('clangd_extensions').setup({
        server = config
    })
end

return M