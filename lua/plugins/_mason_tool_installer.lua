local M = {}

function M.config()
    require('mason-tool-installer').setup({
        ensure_installed = {
            'prettierd',
            'yamlfmt',
            'rust-analyzer',
            -- 'roslyn'
        }
    })

    vim.cmd.MasonToolsInstall()
end

return M
