local M = {}

local function spring_boot_language_server_cmd()
    local ok, registry = pcall(require, "mason-registry")
    if not ok or not registry.is_installed("vscode-spring-boot-tools") then
        return nil
    end

    local package_path = registry.get_package("vscode-spring-boot-tools"):get_install_path()
    return {
        "java",
        "-jar",
        package_path .. "/language-server.jar",
    }
end

local function spring_boot_jdtls_bundles()
    local ok, registry = pcall(require, "mason-registry")
    if not ok or not registry.is_installed("vscode-spring-boot-tools") then
        return {}
    end

    local package_path = registry.get_package("vscode-spring-boot-tools"):get_install_path()
    return vim.fn.glob(package_path .. "/jdtls/*.jar", true, true)
end

function M.setup(config)
    local jdtls_config = vim.tbl_deep_extend("force", {}, config, {
        init_options = {
            bundles = spring_boot_jdtls_bundles(),
        },
        settings = {
            java = {
                configuration = {
                    updateBuildConfiguration = "interactive",
                },
                inlayHints = {
                    parameterNames = {
                        enabled = "all",
                    },
                },
                signatureHelp = {
                    enabled = true,
                },
                sources = {
                    organizeImports = {
                        starThreshold = 9999,
                        staticStarThreshold = 9999,
                    },
                },
            },
        },
    })

    vim.lsp.config("jdtls", jdtls_config)
    vim.lsp.enable("jdtls")

    local spring_cmd = spring_boot_language_server_cmd()
    if spring_cmd == nil then
        return
    end

    local spring_config = vim.tbl_deep_extend("force", {}, config, {
        cmd = spring_cmd,
        filetypes = { "java", "yaml", "jproperties", "properties" },
        root_markers = { "pom.xml", "build.gradle", "build.gradle.kts", "mvnw", "gradlew", ".git" },
    })

    vim.lsp.config("spring_boot_tools", spring_config)
    vim.lsp.enable("spring_boot_tools")
end

return M
