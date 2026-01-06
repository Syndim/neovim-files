local M = {}

function M.config()
    require("trouble").setup({
        preview = {
            type = "main",
        },
        modes = {
            symbols = {
                win = {
                    position = "left",
                },
            },
        },
    })

    local opts = { remap = false }

    -- Lua
    opts.desc = "Open diagnostics window"
    vim.keymap.set("n", "<leader>tt", function()
        vim.cmd.Trouble()
    end, opts)
    opts.desc = "List workspace diagnostics"
    vim.keymap.set("n", "<leader>wd", function()
        vim.cmd.Trouble("diagnostics", "toggle")
    end, opts)
    opts.desc = "List document diagnostics"
    vim.keymap.set("n", "<leader>dd", function()
        vim.cmd.Trouble("diagnostics", "toggle", "filter.buf=0")
    end, opts)
    opts.desc = "List locations"
    vim.keymap.set("n", "<leader>ll", function()
        vim.cmd.Trouble("loclist", "toggle")
    end, opts)
    opts.desc = "Quick fix"
    vim.keymap.set("n", "<leader>qf", function()
        vim.cmd.Trouble("quickfix", "toggle")
    end, opts)
    opts.desc = "Focus symbols"
    vim.keymap.set("n", "<F4>", function()
        vim.cmd.Trouble("symbols", "focus=true")
    end, opts)
end

return M
