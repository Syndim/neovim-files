local M = {}

function M.config()
    require("conform").setup({
        formatters = {
            stylua = {
                prepend_args = { "--indent-type", "Spaces" },
            },
        },
        formatters_by_ft = {
            lua = { "stylua" },
            python = function(bufnr)
                if require("conform").get_formatter_info("ruff_format", bufnr).available then
                    return { "ruff_format" }
                else
                    return { "isort", "black" }
                end
            end,
            rust = { "rustfmt", lsp_format = "fallback" },
            javascript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescript = { "prettierd" },
            typescriptreact = { "prettierd" },
            cpp = { "clang_format" },
            cs = { "csharpier" },
            just = { "just" },
            yaml = { "yamlfmt" },
        },
        default_format_opts = {
            lsp_format = "fallback",
        },
    })
end

return M
