local M = {}

function M.setup(lsp_config, config)
    -- local features = require('features')
    local encoding = "utf-16" -- features.is_copilot_enabled and 'utf-16' or 'utf-8'
    local clang_config = vim.tbl_deep_extend("force", config, {
        capabilities = {
            offsetEncoding = { encoding },
        },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    })
    require("clangd_extensions").setup({})
    lsp_config.clangd.setup(clang_config)
end

return M
