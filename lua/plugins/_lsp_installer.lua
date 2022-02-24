local M = {}

function setup_custom_server(ext_name, server, config)
    require(ext_name).setup({
        server = vim.tbl_deep_extend("force", server:get_default_options(), config)
    })
    server:attach_buffers()
end

function M.config()
    local lsp_installer = require('nvim-lsp-installer')
    local lsp = require('plugins._lsp')
    local servers = {
        'clangd',
        'cmake',
        'cssls',
        'dartls',
        'dockerls',
        'html',
        'jsonls',
        'tsserver',
        'sumneko_lua',
        'pyright',
        'solargraph',
        'rust_analyzer',
        'taplo'
    }

    for _, name in pairs(servers) do
        local server_is_found, server = lsp_installer.get_server(name)
        if server_is_found and not server:is_installed() then
            print("Installing " .. name)
            server:install()
        end
    end

    lsp_installer.on_server_ready(function(server)
        -- Specify the default options which we'll use to setup all servers
        local config = lsp.create_config()

        if server.name == 'rust_analyzer' then
            setup_custom_server('rust-tools', server, config)
        elseif server.name == 'clangd' then
            setup_custom_server('clangd_extensions', server, config)
        elseif server.name == 'dartls' then
            -- Do nothing
        else
            server:setup(config)
        end
    end)
end

return M
