local M = {}

function M.setup(config)
    local util = require("lspconfig.util")
    local sourcekit_config = vim.tbl_deep_extend("force", config, {
        root_dir = function(bufnr, on_dir)
            local filename = vim.api.nvim_buf_get_name(bufnr)
            local root = util.root_pattern("buildServer.json")(filename)
                or util.root_pattern("*.xcodeproj", "*.xcworkspace")(filename)
                or vim.fs.dirname(vim.fs.find(".git", { path = filename, upward = true })[1])
                or util.root_pattern("Package.swift")(filename)
            on_dir(root)
        end,
        filetypes = { "swift" },
    })
    vim.lsp.config("sourcekit", sourcekit_config)
    vim.lsp.enable("sourcekit")
end

return M
