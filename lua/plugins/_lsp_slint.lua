local M = {}

function M.setup(config)
    local encoding = 'utf-16' -- features.is_copilot_enabled and 'utf-16' or 'utf-8'
    local slint_config = vim.tbl_deep_extend('force', config, {
        capabilities = {
            offsetEncoding = { encoding },
            general = {
                positionEncodings = { encoding },
            }
        },
    })
    local lsp_config = require('lspconfig')
    lsp_config['slint_lsp'].setup(slint_config)
end

return M
