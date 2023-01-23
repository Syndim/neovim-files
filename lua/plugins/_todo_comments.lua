local M = {}

function M.config()
    require('todo-comments').setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    })

    local opts = {
        noremap = true
    }
    vim.api.nvim_set_keymap('n', '<leader>td', '<cmd>:TodoTelescope<cr>', opts)
end

return M
