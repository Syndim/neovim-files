local M = {}

function M.config()
    require("yazi").setup({
        open_for_directories = false,
        keymaps = {
            show_help = "<f1>",
        },
        integrations = {
            grep_in_directory = "fzf-lua",
            grep_in_selected_files = "fzf-lua",
        },
    })
end

return M
