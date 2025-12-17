local M = {}

function M.setup()
    vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
            local global = require("global")
            for _, config in pairs(require("nvim-treesitter.parsers")) do
                if config.install_info then
                    config.install_info.url = config.install_info.url:gsub("https://github.com", global.github.url)
                end
            end
            local proxy = os.getenv("HTTPS_PROXY") or ""
            if proxy then
                require("nvim-treesitter.install").command_extra_args = {
                    curl = { "--proxy", proxy },
                }
            end
        end,
    })
end

function M.config()
    local treesitter_path = vim.fn.stdpath("data") .. "/treesitter"
    vim.opt.runtimepath:prepend(treesitter_path)

    local treesitter = require("nvim-treesitter")
    treesitter.setup({
        install_dir = treesitter_path,
    })
    treesitter.install({
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
    })
    vim.api.nvim_create_autocmd("FileType", {
        pattern = { "fish", "ruby", "javascript", "typescript", "typescriptreact", "just", "swift" },
        callback = function()
            vim.treesitter.start()
        end,
    })
    vim.treesitter.language.register("javascript", "typescript")
    vim.treesitter.language.register("typescriptreact", "typescript")
end

return M
