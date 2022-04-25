local M = {}

function M.config()
    require('tree-sitter-just').setup({})
    local global = require('global')
    local install = require("nvim-treesitter.install")
    if global.is_mac then
        install.compilers = { 'clang' }
    end
    install.ensure_installed({ 'just' })
end

return M
