local function load_plugins(plugins)
    require("lazy").load({
        plugins = plugins,
        show = false,
    })
end

local global = require("global")

local M = {
    lsp = {},
    plugin = {
        copilot = {
            enabled = false,
        },
        sidekick = {
            enabled = false,
            config = {},
        },
        xcode_build = {
            enabled = false,
        },
    },
    editor = {
        format_on_save = true,
    },
}

function M.setup(opts)
    local config = vim.tbl_deep_extend("force", M, opts)

    for k, v in pairs(config) do
        M[k] = v
    end

    if not global.is_embedded then
        local plugin_config = config.plugin

        if plugin_config.sidekick.enabled then
            load_plugins({ "copilot.lua", "sidekick.nvim" })
        end

        if plugin_config.copilot.enabled then
            load_plugins({ "copilot.lua" })
        end

        if plugin_config.xcode_build.enabled then
            load_plugins({ "xcodebuild.nvim" })
        end
    else
        config.plugin.sidekick.enabled = false
        config.plugin.copilot.enabled = false
        config.plugin.xcode_build.enabled = false
    end
end

return M
