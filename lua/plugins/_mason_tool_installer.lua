local M = {}

function M.config()
    require('mason-tool-installer').setup({
        ensure_installed = {
            'prettierd',
            'protolint',
            'pylint',
            'hadolint',
            'markdownlint',
            'yamllint',
            'yamlfmt',
            'rust-analyzer'
        }
    })

    vim.cmd.MasonToolsInstall()
end

return M
