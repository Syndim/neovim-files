local M = {}

function M.config()
    local on_attach = require("plugins._lsp").create_on_attach()
    require("typescript-tools").setup({
        on_attach = on_attach,
        filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
            "vue",
        },
        settings = {
            tsserver_plugins = {
                "@vue/typescript-plugin",
            },
        },
    })
end

return M
