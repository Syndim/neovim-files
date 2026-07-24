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

function M.setup()
    vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
            local global = require("global")
            if global.github.url == "https://github.com" then
                return
            end

            for _, config in pairs(require("nvim-treesitter.parsers")) do
                local install_info = config.install_info
                if install_info and install_info.url then
                    install_info.url = install_info.url:gsub("^https://github%.com", global.github.url)
                end
            end
        end,
        desc = "Use configured GitHub mirror for Tree-sitter parsers",
    })
end

function M.config()
    local treesitter_path = vim.fn.stdpath("data") .. "/treesitter"
    vim.opt.runtimepath:prepend(treesitter_path)

    local treesitter = require("nvim-treesitter")
    treesitter.setup({
        install_dir = treesitter_path,
    })
    treesitter.install(ensure_installed)

    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "fish", "ruby", "javascript", "typescript", "typescriptreact", "just", "swift", "vue" },
        callback = function()
            vim.treesitter.start()
        end,
        desc = "Enable Tree-sitter highlighting",
    })
end

return M
