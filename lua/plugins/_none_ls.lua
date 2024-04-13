local M = {}

function M.config()
    local null_ls = require("null-ls")

    null_ls.setup({
        sources = {
            null_ls.builtins.code_actions.gitsigns,
            null_ls.builtins.code_actions.refactoring,

            null_ls.builtins.completion.spell,
            null_ls.builtins.completion.tags,

            null_ls.builtins.diagnostics.actionlint,
            null_ls.builtins.diagnostics.buf,
            null_ls.builtins.diagnostics.dotenv_linter,
            null_ls.builtins.diagnostics.fish,
            null_ls.builtins.diagnostics.glslc.with({
                extra_args = { "--target-env=opengl" }, -- use opengl instead of vulkan1.0
            }),
            null_ls.builtins.diagnostics.hadolint,
            null_ls.builtins.diagnostics.markdownlint,
            null_ls.builtins.diagnostics.protolint,
            null_ls.builtins.diagnostics.yamllint,

            null_ls.builtins.formatting.clang_format,
            null_ls.builtins.formatting.cmake_format,
            null_ls.builtins.formatting.dart_format,
            null_ls.builtins.formatting.just,
            null_ls.builtins.formatting.prettierd,
            null_ls.builtins.formatting.yamlfmt,

            null_ls.builtins.hover.dictionary,
        },
    })
end

return M
