local M = {}

local ensure_installed = {
    "cpp",
    "c_sharp",
    "css",
    "dart",
    "java",
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

local function language_overrides()
    local global = require("global")
    if global.github.url == "https://github.com" then
        return {}
    end

    local overrides = {}
    for lang, config in pairs(require("tree-sitter-manager.repos")) do
        local install_info = config.install_info
        if install_info and install_info.url then
            overrides[lang] = {
                install_info = vim.tbl_deep_extend("force", {}, install_info, {
                    url = install_info.url:gsub("^https://github%.com", global.github.url),
                }),
            }
        end
    end

    return overrides
end

function M.config()
    local treesitter_path = vim.fn.stdpath("data") .. "/treesitter"

    require("tree-sitter-manager").setup({
        parser_dir = treesitter_path .. "/parser",
        query_dir = treesitter_path .. "/queries",
        ensure_installed = ensure_installed,
        languages = language_overrides(),
    })

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "typescript", "javascriptreact", "typescriptreact", "vue" },
        callback = function()
            vim.treesitter.start()
        end,
        desc = "Enable Tree-sitter for filetypes whose parser name differs",
    })
end

return M
