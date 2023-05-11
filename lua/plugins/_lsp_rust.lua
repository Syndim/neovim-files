local M = {}

function M.setup(config)
    local features = require('features')

    local settings = {
        -- to enable rust-analyzer settings visit:
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ['rust-analyzer'] = {
            -- enable clippy on save
            checkOnSave = {
                command = 'clippy'
            },
            procMacro = {
                enable = true
            }
        }
    }

    if features.lsp_config['rust'] ~= nil then
        settings = vim.tbl_deep_extend('force', settings, features.lsp_config['rust'])
    end

    local rust_config = vim.tbl_deep_extend('force', config, {
        standalone = true,
        settings = settings
    })

    require('rust-tools').setup({
        server = rust_config,
    })
end

return M
