local M = {}

function M.config()
    local Snacks = require("snacks")
    local global = require("global")
    Snacks.setup({
        bigfile = { enabled = true },
        notifier = { enabled = true, style = "fancy" },
        quickfile = { enabled = true },
        statuscolumn = { enabled = true },
        words = { enabled = true, debounce = 50 },
        indent = { enabled = true },
        scope = { enabled = true },
        explorer = { enabled = true },
        input = { enabled = true },
        picker = {
            sources = {
                explorer = {
                    win = {
                        list = {
                            wo = {
                                number = true,
                                relativenumber = true,
                            },
                            keys = {
                                ["<Esc>"] = "",
                                ["q"] = "",
                                ["o"] = { "confirm", mode = { "n" } },
                            },
                        },
                    },
                },
            },
        },
    })

    local options = { noremap = true, nowait = true, desc = "Close buffer" }
    vim.keymap.set("n", "<Leader>x", function()
        Snacks.bufdelete()
    end, options)
    options.desc = "Jump to next word"
    vim.keymap.set("n", "<A-n>", function()
        Snacks.words.jump(1)
    end)
    options.desc = "Jump to previous word"
    vim.keymap.set("n", "<A-p>", function()
        Snacks.words.jump(-1)
    end)
    options.desc = "Blame line"
    vim.keymap.set("n", "<Leader>gB", function()
        Snacks.git.blame_line()
    end, options)
    options.desc = "Lazygit Current File History"
    vim.keymap.set("n", "<Leader>gf", function()
        Snacks.lazygit.log_file()
    end, options)
    options.desc = "Lazygit Log (cwd)"
    vim.keymap.set("n", "<Leader>gl", function()
        Snacks.lazygit.log()
    end, options)
    options.desc = "Rename File"
    vim.keymap.set("n", "<Leader>cr", function()
        Snacks.rename.rename_file()
    end, options)
    options.desc = "Toggle terminal"
    vim.keymap.set("", "<F12>", function()
        if global.is_windows then
            local cmd
            local home = os.getenv("HOME")
            if home then
                cmd = "powershell.exe -NoExit -File " .. home .. "/.config/powershell/setup/setup.ps1"
            else
                cmd = vim.o.shell
            end

            Snacks.terminal.toggle(cmd, {
                win = {
                    position = "bottom",
                },
            })
        else
            Snacks.terminal.toggle()
        end
    end)
    vim.api.nvim_create_user_command("Notifications", function()
        Snacks.notifier.show_history({})
    end, { nargs = 0 })
    -- local explorer = nil
    -- options.desc = "Toggle file tree"
    -- vim.keymap.set("", "<F2>", function()
    --     explorer = Snacks.explorer({
    --         follow_file = true,
    --         watch = not global.is_windows,
    --     })
    -- end, options)
    -- options.desc = "Reveal current file"
    -- vim.keymap.set("", "<F3>", function()
    --     if not explorer then
    --         return
    --     end
    --     Snacks.explorer.reveal()
    -- end, options)
    -- vim.api.nvim_create_user_command("SnacksExplorerClose", function()
    --     if explorer and not explorer.is_closed then
    --         explorer:close()
    --     end
    -- end, { nargs = 0 })
end

return M
