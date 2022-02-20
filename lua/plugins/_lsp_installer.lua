local M = {}

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
            require("rust-tools").setup({
                server = vim.tbl_deep_extend("force", server:get_default_options(), config)
            })
            server:attach_buffers()
        elseif server.name == 'dartls' then
            -- Do nothing
        else
            server:setup(config)
        end
    end)
end

return M
