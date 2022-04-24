local M = {}

function M.config()
    require('tree-sitter-just').setup({})
    require("nvim-treesitter.install").ensure_installed({ 'just' })
end

return M
