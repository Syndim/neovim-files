local M = {}

-- Remember to put flutter's bin folder to PATH
function M.config()
    local lsp = require('plugins._lsp')
    require("flutter-tools").setup({
        decorations = {
            statusline = {
                -- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
                -- this will show the current version of the flutter app from the pubspec.yaml file
                app_version = false,
                -- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
                -- this will show the currently running device if an application was started with a specific
                -- device
                device = true,
            }
        },
        lsp = {
            on_attach = lsp.create_on_attach(),
            capabilities = lsp.get_capabilities()
        }
    })
end

return M
