local M = {}

function M.setup()

    local g = vim.g

    g.ale_linters = {
        cs = { 'OmniSharp' }
    }
    g.ale_linters_explicit = 1
    g.ale_disable_lsp = 1
    g.ale_sign_warning = '⚠'
end

return M
