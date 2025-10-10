local M = {}

function M.config()
    require("todo-comments").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    })

    local opts = {
        remap = false,
    }

    opts.desc = "Open todo"
    vim.keymap.set("n", "<leader>td", vim.cmd.TodoFzfLua, opts)
    -- vim.keymap.set("n", "<leader>td", vim.cmd.TodoTelescope, opts)
end

return M
