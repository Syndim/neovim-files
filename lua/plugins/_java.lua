local M = {}

function M.config()
    require("java").setup({
        jdtls = {
            -- Match the active Java 17 runtime; newer nvim-java defaults require Java 21+.
            version = "1.43.0",
        },
        lombok = {
            version = "1.18.40",
        },
        java_test = {
            version = "0.40.1",
        },
        java_debug_adapter = {
            version = "0.58.2",
        },
        spring_boot_tools = {
            version = "1.55.1",
        },
        jdk = {
            -- Avoid blocking Neovim while nvim-java downloads a full JDK on first Java file open.
            auto_install = false,
        },
    })
    vim.lsp.enable("jdtls")
end

return M
