local M = {}

function M.config()
    local vscode = require('vscode');

    vscode.setup({
        style = 'dark'
    })
    vscode.load()
end

return M
