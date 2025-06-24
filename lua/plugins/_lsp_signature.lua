local M = {}

function M.config()
    local opts = {
        doc_lines = 98,
        max_height = 100,
        hint_enable = false,
        handler_opts = {
            border = "none",
        },
    }
    require("lsp_signature").setup(opts)
end

return M
