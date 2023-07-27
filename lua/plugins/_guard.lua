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

    require('guard').setup({
        fmt_on_save = false,
        lsp_as_default_formatter = false
    })
end

return M
