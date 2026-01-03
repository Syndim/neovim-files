local M = {}

function M.config()
    local spectre = require("spectre")
    spectre.setup({})

    local opts = {
        remap = false,
    }
    opts.desc = "Open Spectre"
    vim.keymap.set("n", "<leader>s", spectre.open, opts)
    vim.api.nvim_create_user_command("SpectreClose", spectre.close, { nargs = 0 })
end

return M
