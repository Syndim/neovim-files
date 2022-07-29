local M = {}

function M.config()
    local global = require('global')
    local function which(cmd)
        local redirect = ' > /dev/null 2>&1'
        local which = 'which'
        if global.is_windows then
            redirect = ' > nul 2>&1'
            which = 'where.exe'
        end

        return os.execute(which .. ' ' .. cmd .. redirect)
    end

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

    -- Custom settings
    require('plugins._lsp_lua').setup(lsp_config, config)
    require('plugins._lsp_csharp').setup(lsp_config, lsp, config)
    require('plugins._lsp_rust').setup(config)
    require('plugins._lsp_clang').setup(config)
    require('plugins._lsp_python').setup(lsp_config, config)

    if which('flutter') == 0 then
        require('plugins._lsp_flutter').setup(lsp, config)
    end

    -- Optional LSP
    for name, condition in pairs(optional_servers) do
        if which(condition) == 0 then
            lsp_config[name].setup(config)
        end
    end
end

return M
