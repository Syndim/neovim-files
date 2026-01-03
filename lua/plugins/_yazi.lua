local M = {}

function M.config()
    require("yazi").setup({
        open_for_directories = false,
        keymaps = {
            show_help = "<f1>",
        },
    })
end

return M
