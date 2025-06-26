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
        avante = {
            enabled = false,
            provider = nil,
            openai = nil,
            azure = nil,
            claude = nil,
            copilot = nil,
        },
        codeium = {
            enabled = false,
            strategies = nil,
            adapters = nil,
        },
        copilot = {
            enabled = false,
        },
        code_companion = {
            enabled = false,
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
        -- if plugin_config.avante.enabled then
        -- 	load_plugins({ "copilot.lua", "avante.nvim" })
        -- end

        if plugin_config.code_companion.enabled then
            load_plugins({ "copilot.lua", "codecompanion.nvim" })
        end

        if plugin_config.copilot.enabled then
            load_plugins({ "copilot.lua" })
        end

        if plugin_config.codeium.enabled then
            load_plugins({ "codeium.nvim" })
        end

        if plugin_config.xcode_build.enabled then
            load_plugins({ "xcodebuild.nvim" })
        end
    else
        -- config.plugin.avante.enabled = false
        config.plugin.code_companion.enabled = false
        config.plugin.copilot.enabled = false
        config.plugin.xcode_build.enabled = false
    end
end

return M
