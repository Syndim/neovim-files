local M = {}

function M.config()
    local global = require('global')

    local mason = require('mason')
    local mason_lsp_config = require('mason-lspconfig')
    local lsp = require('plugins._lsp')
    local lsp_config = require('lspconfig')
    local common_servers = {
        'cmake',
        'cssls',
        'dockerls',
        'html',
        'jsonls',
        'tsserver',
        'taplo', -- toml
        'bashls',
        'yamlls',
        'kotlin_language_server',
    }

    local optional_servers = {
        powershell_es = 'pwsh',
        sourcekit     = 'swift',
        solargraph    = 'ruby',
    }

    mason.setup({
        github = {
            download_url_template = "https://ghproxy.com/https://github.com/%s/releases/download/%s/%s",
        },
    })
    mason_lsp_config.setup({
        automatic_installation = true
    })

    -- Specify the default options which we'll use to setup all servers
    local config = lsp.create_config()

    -- Common LSP
    for _, name in ipairs(common_servers) do
        lsp_config[name].setup(config)
    end

    -- Taplo in the registry doesn't contain Windows definition
    if global.is_windows then
        local mason_registry = require('mason-registry')
        local taplo_assets = mason_registry.get_package('taplo').spec.source.asset
        table.insert(taplo_assets, {
            target = 'win_x64',
            file = 'taplo-full-windows-x86_64.zip',
            bin = 'taplo.exe'
        })
    end

    -- Custom settings
    require('plugins._lsp_lua').setup(lsp_config, config)
    require('plugins._lsp_csharp').setup(lsp_config, lsp, config)
    require('plugins._lsp_rust').setup(config)
    require('plugins._lsp_clang').setup(config)
    require('plugins._lsp_python').setup(lsp_config, config)

    if global:which('flutter') == 0 then
        require('plugins._lsp_flutter').setup(lsp, config)
    end

    -- Optional LSP
    for name, condition in pairs(optional_servers) do
        if global:which(condition) == 0 then
            lsp_config[name].setup(config)
        end
    end
end

return M
