local M = {}

function M.config()
    local config = {
        use_bundled_binary = true,
        auto_approve = function(params)
            if vim.g.codecompanion_auto_tool_mode == true then
                return true -- Auto approve when CodeCompanion auto-tool mode is on
            end

            if params.server_name == "neovim" then
                return true
            end

            if params.is_auto_approved_in_server then
                return true -- Respect servers.json configuration
            end
            return false
        end,
        builtin_tools = {
            replace_in_file = {
                keymaps = {
                    accept = "ga",
                    reject = "gs",
                },
            },
        },
    }

    require("mcphub").setup(config)
end

return M
