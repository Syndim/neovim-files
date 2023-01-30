local M = {}

function M.setup(config)
    local clang_config = vim.tbl_deep_extend('force', config, {
        capabilities = {
            offsetEncoding = "utf-8"
        }
    })
    require('clangd_extensions').setup({
        server = clang_config
    })
end

return M
