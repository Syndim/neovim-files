local M = {}

function M.config()
    require('mason-tool-installer').setup({
        ensure_installed = {
            'ruff-lsp',
            -- 'ruff',
            -- 'hadolint',
            'eslint_d',
            'prettierd',
            'efm',
            'autopep8'
        }
    })
end

return M
