local M = {}

function M.config()
    local oil = require("oil")
    oil.setup({
        float = {
            preview_split = "right",
        },
        keymaps = {
            ["<C-c>"] = false,
            ["<ESC>"] = { "actions.close", mode = "n" },
        },
    })

    vim.keymap.set("n", "<leader>o", function()
        if vim.w.is_oil_win then
            oil.close()
        else
            oil.open_float(nil, { preview = {} })
        end
    end, { desc = "Toggle file expl[o]rer", silent = true })
end

return M
