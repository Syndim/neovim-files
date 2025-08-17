local M = {}

function M.setup(config)
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
    vim.lsp.config("lua_ls", lua_config)
    vim.lsp.enable("lua_ls")
end

return M
