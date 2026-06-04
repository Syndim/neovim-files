local M = {}

local ensure_installed = {
    "cpp",
    "c_sharp",
    "css",
    "dart",
    "javascript",
    "json",
    "kotlin",
    "lua",
    "python",
    "regex",
    "ruby",
    "rust",
    "scss",
    "toml",
    "typescript",
    "yaml",
    "fish",
    "vim",
    "slint",
    "html",
    "tsx",
    "vimdoc",
    "just",
    "markdown",
    "swift",
    "vue",
}

local function patch_registry_for_github_mirror()
    local global = require("global")
    if global.github.url == "https://github.com" then
        return
    end

    local registry = require("arborist.registry")
    local original_resolve = registry.resolve

    local function rewrite(url)
        if type(url) ~= "string" then return url end
        return (url:gsub("^https://github%.com", global.github.url))
    end

    registry.resolve = function(lang)
        local info = original_resolve(lang)
        if not info then return info end
        info = vim.deepcopy(info)
        info.url = rewrite(info.url)
        info.fallback_url = rewrite(info.fallback_url)
        return info
    end
end

function M.config()
    patch_registry_for_github_mirror()

    require("arborist").setup({
        ensure_installed = ensure_installed,
    })
end

return M
