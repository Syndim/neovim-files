local function load_plugins(plugins)
    require('lazy').load({
        plugins = plugins,
        show = false
    })
end

local M = {
    format_on_save_enabled = true,
    lsp_config = {},

    enable_copilot = function()
        load_plugins({ 'copilot.lua', 'copilot-status.nvim' })
    end,

    enable_codeium = function()
        load_plugins({ 'codeium.nvim' })
    end
}

return M
