local M = {}

function M.config()
    require('nu').setup({
        complete_cmd_names = true, -- requires https://github.com/jose-elias-alvarez/null-ls.nvim
    })

    require("nvim-treesitter.install").ensure_installed({ 'nu' })
end

return M
