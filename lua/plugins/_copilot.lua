local M = {}

local copilot_initiazlied = false

local function is_enabled()
    local c = require("copilot.client")
    return not c.is_disabled() and c.buf_is_attached(vim.api.nvim_get_current_buf())
end

local function is_loading()
    local a = require("copilot.api")

    local data = a.status.data.status
    if data == "InProgress" then
        return true
    end

    return false
end

function M.status()
    if copilot_initiazlied then
        if is_loading() then
            return ""
        elseif is_enabled() then
            return ""
        else
            return ""
        end
    end

    return ""
end

function M.config()
    require("copilot").setup({
        panel = {
            enabled = false,
        },
        suggestion = {
            enabled = true,
            auto_trigger = true,
            -- keymap = {
            --     accept = "<C-f>",
            -- },
        },
    })

    local opts = { expr = true, replace_keycodes = false }
    opts.desc = "Accept copilot suggestion"
    vim.keymap.set("i", "<C-f>", function()
        require("copilot.suggestion").accept()
    end, opts)
    vim.keymap.set("i", "<A-f>", function()
        require("copilot.suggestion").accept_word()
    end, opts)
    copilot_initiazlied = true
end

return M
