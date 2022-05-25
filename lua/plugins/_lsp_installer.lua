local M = {}

function M.config()
    local global = require('global')
    local function setup_custom_server(ext_name, server, config)
        require(ext_name).setup({
            server = vim.tbl_deep_extend('force', server:get_default_options(), config)
        })
        server:attach_buffers()
    end

    local function execute(cmd)
        local redirect = ' > /dev/null 2>&1'
        if global.is_windows then
            redirect = ' > nul 2>&1'
        end

        return os.execute(cmd .. redirect)
    end

    local lsp_installer = require('nvim-lsp-installer')
    local lsp = require('plugins._lsp')
    local servers = {
        clangd = {},
        cmake = {},
        cssls = {},
        dartls = {},
        dockerls = {},
        html = {},
        jsonls = {},
        tsserver = {},
        sumneko_lua = {},
        pyright = {},
        solargraph = {
            pre_install_check = function()
                return execute('ruby --version') == 0
            end
        },
        rust_analyzer = {},
        taplo = {
            pre_install_check = function()
                return execute('cargo --version') == 0
            end
        }, -- toml
        omnisharp = {},
        bashls = {},
        powershell_es = {
            pre_install_check = function()
                return execute('pwsh --version') == 0
            end
        },
        yamlls = {},
        kotlin_language_server = {},
        sourcekit = {
            pre_install_check = function()
                return execute('swfit -version') == 0
            end
        }, -- swift
    }

    for name, settings in pairs(servers) do
        local server_is_found, server = lsp_installer.get_server(name)
        if server_is_found and not server:is_installed() then
            if settings.pre_install_check == nil or settings.pre_install_check() then
                print('Installing ' .. name)
                server:install()
            end
        end
    end

    lsp_installer.on_server_ready(function(server)
        -- Specify the default options which we'll use to setup all servers
        local config = lsp.create_config()

        if server.name == 'rust_analyzer' then
            setup_custom_server('rust-tools', server, config)
        elseif server.name == 'clangd' then
            setup_custom_server('clangd_extensions', server, config)
        elseif server.name == 'sumneko_lua' then
            local lua_config = vim.tbl_deep_extend('force', config, {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { 'vim', 'hs', 'spoon' },
                        },
                        workspace = {
                            library = {
                                os.getenv('HOME') .. '/.hammerspoon/Spoons/EmmyLua.spoon/annotations',
                                vim.api.nvim_get_runtime_file('', true),
                            }
                        },
                        telemetry = {
                            enable = false,
                        },
                    }
                }
            })
            server:setup(lua_config)
        elseif server.name == 'omnisharp' then
            local handlers_config = config['handlers']
            if handlers_config == nil then
                config['handlers'] = {}
            end
            local default_on_attach = lsp.create_on_attach()
            local function on_attach(client, bufnr)
                default_on_attach(client, bufnr)
                vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua require("omnisharp_extended").telescope_lsp_definitions()<CR>', { noremap = true, silent = true })
            end

            config['on_attach'] = on_attach
            config['handlers']['textDocument/definition'] = require('omnisharp_extended').handler
            server:setup(config)
        elseif server.name == 'dartls' then
            -- Do nothing
        else
            server:setup(config)
        end
    end)
end

return M
