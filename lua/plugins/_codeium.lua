local M = {}

local codeium_initialized = false

function M.status()
    if codeium_initialized then
        local status = require("codeium.virtual_text").status()
        if status.state == "idle" then
            return "󱃖"
        elseif status.state == "completions" then
            return string.format("%d/%d", status.current, status.total)
        elseif status.state == "waiting" then
            return ""
        else
            return "󱃖"
        end
    end

    return ""
end

function M.config()
    local global = require("global")

    if global.github.has_proxy then
        -- patch download method
        local update = require("codeium.update")
        local original_download = update.download
        local function download(callback)
            local info = update.get_bin_info()
            info.download_url = string.gsub(info.download_url, "https://github.com", global.github.url)
            original_download(callback)
        end
        update.download = download
    end

    require("codeium").setup({
        detect_proxy = true,
        enable_chat = false,
        enable_cmp_source = false,
        virtual_text = {
            enabled = true,
            key_bindings = {
                accept = "<C-f>",
                next = "<M-]>",
                prev = "<M-[>",
                clear = "<C-]>",
            },
        },
    })

    codeium_initialized = true
end

return M
