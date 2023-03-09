local M = {}

function M.setup(config)
    local rust_config = vim.tbl_deep_extend('force', config, {
        standalone = true,
    })

    require('rust-tools').setup({
        server = rust_config,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
                ['rust-analyzer'] = {
                -- enable clippy on save
                checkOnSave = {
                    command = 'clippy'
                },
            }
        }
    })
end

return M
