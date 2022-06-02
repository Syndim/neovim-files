local M = {}

function M.config()
    local global = require('global')
    local function execute(cmd)
        local redirect = ' > /dev/null 2>&1'
        if global.is_windows then
            redirect = ' > nul 2>&1'
        end

        return os.execute(cmd .. redirect)
    end

    local lsp_installer = require('nvim-lsp-installer')
    local lsp = require('plugins._lsp')
    local lsp_config = require('lspconfig')
    local common_servers = {
        cmake,
        cssls,
        dartls,
        dockerls,
        html,
        jsonls,
        tsserver,
        pyright,
        solargraph,
        taplo, -- toml
        bashls,
        yamlls,
        kotlin_language_server,
    }

    local optional_servers = {
        powershell_es = 'pwsh --version',
        sourcekit  = 'swift -version'
    }

    lsp_installer.setup({
        automatic_installation = true,
        github = {
            download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s",
        },
    })

    -- Specify the default options which we'll use to setup all servers
    local config = lsp.create_config()

    -- Common LSP
    for _, name in ipairs(common_servers) do
        lsp_config[name].setup(config)
    end

    -- Custom settings
    require('plugins._lsp_lua').setup(lsp_config, config)
    require('plugins._lsp_csharp').setup(lsp_config, lsp, config)
    require('plugins._lsp_flutter').setup(lsp, config)
    require('plugins._lsp_rust').setup(config)
    require('plugins._lsp_clang').setup(config)

    -- Optional LSP
    for name, condition in pairs(optional_servers) do
        if execute(condition) == 0 then
            lsp_config[name].setup(config)
        end
    end
end

return M
