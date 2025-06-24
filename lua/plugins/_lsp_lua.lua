local M = {}

function M.setup(lsp_config, config)
    local lua_config = vim.tbl_deep_extend("force", config, {
        settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim", "hs", "spoon" },
                },
                workspace = {
                    library = {
                        os.getenv("HOME") .. "/.hammerspoon/Spoons/EmmyLua.spoon/annotations",
                        vim.api.nvim_get_runtime_file("", true),
                    },
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    })
    lsp_config.lua_ls.setup(lua_config)
end

return M
