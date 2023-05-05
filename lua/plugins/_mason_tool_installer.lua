local M = {}

function M.config()
    require('mason-tool-installer').setup({
        ensure_installed = {
            'pylint',
            'hadolint',
        }
    })
end

return M
