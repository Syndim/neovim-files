local M = {}

function M.config()
    local null_ls = require('null-ls')
    null_ls.setup({
        sources = {
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.code_actions.gitrebase,
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.diagnostics.ruff,
            null_ls.builtins.diagnostics.tsc,
            null_ls.builtins.diagnostics.clang_check,
            null_ls.builtins.diagnostics.cmake_lint,
            null_ls.builtins.diagnostics.fish,
            null_ls.builtins.diagnostics.hadolint,
            null_ls.builtins.diagnostics.protoc_gen_lint,
            null_ls.builtins.formatting.prettierd.with({
                filetypes = {
                    "javascript",
                    "javascriptreact",
                    "typescript",
                    "typescriptreact",
                    "vue",
                    "css",
                    "scss",
                    "less",
                    "html",
                    "json",
                    "jsonc"
                }
            }),
        },
    })
end

return M
