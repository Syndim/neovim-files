local M = {}

function M.config()
    local edgy = require("edgy")
    edgy.setup({
        animate = {
            enabled = false,
        },
        options = {
            left = {
                size = 35,
            },
        },
        left = {
            {
                title = "Neo-Tree",
                ft = "neo-tree",
                filter = function(buf)
                    return vim.b[buf].neo_tree_source == "filesystem"
                end,
                size = { height = 0.7 },
            },
            {
                title = function()
                    local buf_name = vim.api.nvim_buf_get_name(0) or "Outline: [No Name]"
                    return "Outline: " .. vim.fn.fnamemodify(buf_name, ":t")
                end,
                ft = "Outline",
                pinned = true,
                open = "OutlineOpen!",
                filter = function(buf, win)
                    -- Extra safety: only consider true editor splits (ignore floats)
                    local is_editor_split = vim.api.nvim_win_get_config(win).relative == ""
                    return is_editor_split and vim.bo[buf].filetype == "Outline"
                end,
            },
        },
    })

    vim.keymap.set({ "n", "v" }, "<F2>", function()
        vim.cmd.Neotree("toggle")
        edgy.toggle("left")
    end)
end

return M
