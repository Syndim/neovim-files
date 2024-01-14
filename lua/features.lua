local function load_plugins(plugins)
    require('lazy').load({
        plugins = plugins,
        show = false
    })
end

local M = {
    format_on_save_enabled = true,
    lsp_config = {},

    is_copilot_enabled = false,
    is_codeium_enabled = false,

    enable_copilot = function()
        load_plugins({ 'copilot.lua', 'copilot-status.nvim' })
        require('features').is_copilot_enabled = true
    end,

    enable_codeium = function()
        load_plugins({ 'codeium.vim' })
        require('features').is_codeium_enabled = true
    end
}

return M
