local M = {}

function M.config()
    local null_ls = require('null-ls')
    null_ls.setup({
        sources = {
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.code_actions.gitrebase,
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.diagnostics.eslint_d,
            -- null_ls.builtins.diagnostics.pylint,
            null_ls.builtins.diagnostics.tsc
        },
    })
end

return M
