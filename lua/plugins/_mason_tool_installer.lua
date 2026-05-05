local M = {}

function M.config()
    require("mason-tool-installer").setup({
        -- Servers below are not migrated to Neovim's new LSP configuration
        ensure_installed = {
            "prettierd",
            "yamlfmt",
            "stylua",
            -- "csharpier",
            "vale",
            "google-java-format",
            "vscode-spring-boot-tools",
        },
    })

    vim.cmd.MasonToolsInstall()
end

return M
