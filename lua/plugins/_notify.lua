local M = {}

function M.config()
    local notify = require('notify')
    notify.setup({
        timeout = 3000,
        max_height = function()
            return math.floor(vim.o.lines * 0.75)
        end,
        max_width = function()
            return math.floor(vim.o.columns * 0.75)
        end,
    })
    vim.notify = function(msg, level, opts)
        if string.len(msg) > 0 then
            notify.notify(msg, level, opts)
        end
    end

    local opts = {
        noremap = true
    }

    vim.api.nvim_set_keymap('n', '<leader>dn', '<cmd>lua require("notify").dismiss()<CR>', opts)
end

return M
