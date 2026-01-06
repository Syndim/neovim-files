local M = {}

function M.config()
    local edgy = require("edgy")
    edgy.setup({
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
                    local buf_name = vim.api.nvim_buf_get_name(0) or "[No Name]"
                    return vim.fn.fnamemodify(buf_name, ":t")
                end,
                ft = "trouble",
                pinned = true,
                open = function()
                    vim.cmd.Trouble("symbols")
                end,
                filter = function(buf, win)
                    return vim.w[win].trouble
                        and vim.w[win].trouble.position == "left"
                        and vim.w[win].trouble.type == "split"
                        and vim.w[win].trouble.relative == "editor"
                        and not vim.w[win].trouble_preview
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
