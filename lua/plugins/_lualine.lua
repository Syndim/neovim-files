local M = {}

function M.config()
    require("lualine").setup({
        options = {
            theme = "catppuccin",
            component_separators = "",
            icons_enabled = true,
        },
        sections = {
            lualine_a = {
                { "mode", upper = true, color = { gui = "bold" } },
            },
            lualine_b = {
                { "branch" },
                { "diff", colored = false },
                { "diagnostics", sources = { "nvim_diagnostic", "nvim_lsp" } },
            },
            lualine_c = {
                { "filename", path = 1, file_status = true },
            },
            lualine_x = {
                { require("plugins._copilot").status },
                { require("plugins._codeium").status },
                { "lsp_status" },
                { "filetype", colored = true },
                "encoding",
                "fileformat",
            },
            lualine_y = { { "progress" } },
            lualine_z = {
                { "location", color = { gui = "bold" } },
            },
        },
        extensions = { "quickfix", "fzf", "nvim-tree" },
    })
end

return M
