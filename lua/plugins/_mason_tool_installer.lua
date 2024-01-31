local M = {}

function M.config()
    require('mason-tool-installer').setup({
        ensure_installed = {
            'ruff-lsp',
            -- 'ruff',
            'eslint_d',
            'prettierd',
            'autopep8',
            'rust-analyzer',
            'codespell',
            'typos',
            'cpplint',
            'protolint',
            'pylint',
            'jsonlint',
            'hadolint',
            'markdownlint',
            'yamllint'
        }
    })
end

return M
