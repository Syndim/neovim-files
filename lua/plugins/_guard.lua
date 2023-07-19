local M = {}

function M.config()
    local ft = require('guard.filetype')

    local prettierd = {
        cmd = 'prettierd',
        args = { '--stdin-filepath' },
        fname = true,
        stdin = true,
    }

    local eslint_d = {
        cmd = 'eslint_d',
        args = { "--fix-to-stdout", "--stdin" },
        stdin = true,
    }

    ft('typescriptreact')
        :fmt(prettierd)
        :lint(eslint_d)

    ft('*'):fmt('lsp')

    require('guard').setup({
        fmt_on_save = true,
        lsp_as_default_formatter = true
    })
end

return M
