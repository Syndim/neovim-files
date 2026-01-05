local M = {}

function M.config()
    require("outline").setup({
        outline_window = {
            position = "right",
            show_numbers = true,
            show_relative_numbers = true,
            width = 20,
        },
        preview_window = {
            auto_preview = true,
        },
    })
    vim.keymap.set("n", "<F4>", vim.cmd.OutlineFocus, {})
end

return M
