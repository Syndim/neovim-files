local M = {}

function M.config()
    require('dressing').setup({
        select = {
            enabled = false
        }
    })
end

function M.init()
    vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
    end
    vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
    end
end

return M
