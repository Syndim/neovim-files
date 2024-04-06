local M = {}

function M.config()
    require("obsidian").setup({
        workspaces = {
            {
                name = "buf-parent",
                path = function()
                    return assert(vim.fs.dirname(vim.api.nvim_buf_get_name(0)))
                end,
            },
        },
        notes_subdir = "Notes",
        daily_notes = {
            -- Optional, if you keep daily notes in a separate directory.
            folder = "Daily Log",
            -- Optional, if you want to change the date format for the ID of daily notes.
            date_format = "%Y/%m/%Y-%m-%d",
            -- Optional, if you want to change the date format of the default alias of daily notes.
            -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
            template = 'Daily Log Template.md'
        },
        templates = {
            subdir = "Templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            -- A map for custom variables, the key should be the variable and the value a function
            substitutions = {},
        },

    })
end

return M
