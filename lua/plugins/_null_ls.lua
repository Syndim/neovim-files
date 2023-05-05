local M = {}

function M.config()
    local null_ls = require('null-ls')
    null_ls.setup({
        sources = {
            null_ls.builtins.code_actions.eslint,
            null_ls.builtins.code_actions.gitrebase,
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.diagnostics.eslint,
            -- null_ls.builtins.diagnostics.pylint,
            null_ls.builtins.diagnostics.tsc,
            null_ls.builtins.diagnostics.clang_check,
            null_ls.builtins.diagnostics.cmake_lint,
            null_ls.builtins.diagnostics.fish,
            null_ls.builtins.diagnostics.hadolint,
            null_ls.builtins.diagnostics.protoc_gen_lint,
        },
    })
end

return M
