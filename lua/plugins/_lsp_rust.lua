local M = {}

function M.setup(config)
    local rust_config = vim.tbl_deep_extend('force', config, {
        standalone = true,

        -- TODO: Remove this settings below after issue in rust-tool has been fixed: https://github.com/simrat39/rust-tools.nvim/issues/300
        settings = {
            ["rust-analyzer"] = {
                inlayHints = { locationLinks = false },
            },
        },
    })

    require('rust-tools').setup({
        server = rust_config
    })
end

return M

