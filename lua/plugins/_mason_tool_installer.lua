local M = {}

function M.config()
    require('mason-tool-installer').setup({
        ensure_installed = {
            'ruff',
            'hadolint',
            'eslint_d',
            'prettierd'
        }
    })
end

return M
