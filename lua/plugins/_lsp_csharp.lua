local M = {}

function M.setup(lsp_config, lsp, config)
    local handlers_config = config['handlers']
    if handlers_config == nil then
        handlers_config = {}
    end
    handlers_config["textDocument/definition"] = require('omnisharp_extended').definition_handler
    handlers_config["textDocument/typeDefinition"] = require('omnisharp_extended').type_definition_handler
    handlers_config["textDocument/references"] = require('omnisharp_extended').references_handler
    handlers_config["textDocument/implementation"] = require('omnisharp_extended').implementation_handler

    local default_on_attach = lsp.create_on_attach()
    local function on_attach(client, bufnr)
        print('on attach')
        default_on_attach(client, bufnr)
        local opts = { remap = false, buffer = bufnr }
        opts.desc = 'C# go to definition'
        vim.keymap.set('n', 'gd',
            function() require("omnisharp_extended").telescope_lsp_definitions() end, opts)
    end

    -- local function root_dir(fname)
    --     local util = require('lspconfig.util')
    --     return util.root_pattern('*.sln')(fname) or util.root_pattern('*.csproj')(fname) or
    --         util.root_pattern('omnisharp.json')(fname)
    -- end

    local omnisharp_config = vim.tbl_deep_extend('force', config, {
        handlers = handlers_config,
        on_attach = on_attach,
        -- root_dir = root_dir,
        settings = {
            FormattingOptions = {
                EnableEditorConfigSupport = true,
                OrganizeImports = true
            },
            RoslynExtensionsOptions = {
                EnableAnalyzersSupport = true,
                EnableImportCompletion = true
            }
        }
    })

    lsp_config.omnisharp.setup(omnisharp_config)
end

return M
