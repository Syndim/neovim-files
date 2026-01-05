local M = {}

function M.config()
    require("neo-tree").setup({
        close_if_last_window = true,
        filesystem = {
            follow_current_file = {
                enabled = true,
            },
            window = {
                mappings = {
                    ["o"] = "open",
                    ["oc"] = "noop",
                    ["od"] = "noop",
                    ["og"] = "noop",
                    ["om"] = "noop",
                    ["on"] = "noop",
                    ["os"] = "noop",
                    ["ot"] = "noop",
                },
            },
        },
    })
end

return M
