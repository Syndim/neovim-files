local M = {}

function M.config()
    local on_attach = require('plugins._lsp').create_on_attach()
    require("typescript-tools").setup({
        on_attach = on_attach
    })
end

return M
