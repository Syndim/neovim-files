local M = {}

function M.setup(config)
    local rust_config = vim.tbl_deep_extend('force', config, {
        standalone = true
    })

    require('rust-tools').setup({
        server = rust_config
    })
end

return M