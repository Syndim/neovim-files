local M = {}

function M.setup(lsp_config, config)
    local ts_config = vim.tbl_deep_extend('force', config, {
        on_attach = function(client, bufnr)
            config.on_attach(client, bufnr)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end
    })
    lsp_config.tsserver.setup(ts_config)
end

return M
