local M = {}

function M.config()
    -- Work around mise's `.cmd` shim being broken when fzf-lua spawns a child
    -- via `cmd.exe /e:off ...` (extensions off makes `%*` literal, so the shim
    -- ends up calling `<tool> *`). Resolve each tool to its real binary path
    -- and pass that to fzf-lua, bypassing the shim entirely.
    local function mise_which(tool)
        local out = vim.fn.system({ "mise", "which", tool })
        if vim.v.shell_error == 0 then
            return (out:gsub("%s+$", ""))
        end

        return nil
    end

    local function build_cmd(bin, opts_string)
        if bin and opts_string then
            return bin .. " " .. opts_string
        end

        return nil
    end

    local defaults = require("fzf-lua.defaults").defaults
    local fzf_bin = mise_which("fzf") or "fzf"
    local files_cmd = build_cmd(mise_which("fd"), (defaults.files or {}).fd_opts)
    local grep_cmd = build_cmd(mise_which("rg"), (defaults.grep or {}).rg_opts)

    local fzf = require("fzf-lua")

    local setup_config = {
        fzf_bin = fzf_bin,
        keymap = {
            builtin = {
                ["<C-u>"] = "preview-page-up",
                ["<C-d>"] = "preview-page-down",
            },
        },
        actions = {
            files = {
                true,
                ["alt-i"] = fzf.actions.toggle_ignore,
                ["alt-o"] = fzf.actions.toggle_hidden,
            },
        },
        files = {
            hidden = false,
        },
        grep = {},
    }

    if files_cmd then
        setup_config.files.cmd = files_cmd
    end
    if grep_cmd then
        setup_config.grep.cmd = grep_cmd
    end

    fzf.setup(setup_config)

    fzf.register_ui_select()

    local opts = {
        noremap = true,
    }
    opts.desc = "Find files"
    vim.keymap.set("n", "<C-p>", function()
        fzf.files()
    end, opts)
    opts.desc = "Find buffers"
    vim.keymap.set("n", "<Leader>fb", function()
        fzf.buffers()
    end, opts)
    vim.keymap.set("n", "<A-o>", function()
        fzf.buffers()
    end, opts)
    opts.desc = "Git status"
    vim.keymap.set("n", "<Leader>gs", function()
        fzf.git_status()
    end, opts)
    opts.desc = "Git branches"
    vim.keymap.set("n", "<Leader>gb", function()
        fzf.git_branches()
    end, opts)
    opts.desc = "Find keymaps"
    vim.keymap.set("n", "<Leader>km", function()
        fzf.keymaps()
    end, opts)
    opts.desc = "Find commands"
    vim.keymap.set("n", "<Leader>cm", function()
        fzf.commands()
    end, opts)
    vim.keymap.set("n", "<A-u>", function()
        fzf.commands()
    end, opts)
    opts.desc = "Jump list"
    vim.keymap.set("n", "<Leader>jl", function()
        fzf.jumps()
    end, opts)
    vim.keymap.set("n", "<A-i>", function()
        fzf.jumps()
    end, opts)
end

return M
