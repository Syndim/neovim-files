local M = {}

function M.config()
    require("java").setup()
    vim.lsp.enable("jdtls")
end

return M
