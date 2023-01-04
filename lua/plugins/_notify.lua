local M = {}

function M.config()
    local notify_fn = require('notify')
    vim.notify = function(msg, level, opts)
        if string.len(msg) > 0 then
            notify_fn(msg, level, opts)
        end
    end

    local opts = {
        noremap = true
    }

    vim.api.nvim_set_keymap('n', '<leader>dn', '<cmd>lua require("notify").dismiss()<CR>', opts)
end

return M
