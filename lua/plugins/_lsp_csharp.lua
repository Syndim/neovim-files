local M = {}

function M.setup(lsp_config, lsp, config)
    local handlers_config = config['handlers']
    if handlers_config == nil then
        handlers_config = {}
    end
    handlers_config['textDocument/definition'] = require('omnisharp_extended').handler

    local default_on_attach = lsp.create_on_attach()
    local function on_attach(client, bufnr)
        default_on_attach(client, bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
            '<cmd>lua require("omnisharp_extended").telescope_lsp_definitions()<CR>', { noremap = true, silent = true })

        -- start issue https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
        -- get the list of tokens from lua =vim.lsp.get_active_clients()[1] and just replace the spaces with underscores
        local function toSnakeCase(str)
            return string.gsub(str, "%s*[- ]%s*", "_")
        end

        local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
        for i, v in ipairs(tokenModifiers) do
            tokenModifiers[i] = toSnakeCase(v)
            -- print(tokenModifiers[i])
        end
        local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
        for i, v in ipairs(tokenTypes) do
            tokenTypes[i] = toSnakeCase(v)
            -- print(tokenTypes[i])
        end
        -- client.server_capabilities.semanticTokensProvider = nil
        -- end
    end

    local function root_dir(fname)
        local util = require('lspconfig.util')
        return util.root_pattern('*.sln')(fname) or util.root_pattern('*.csproj')(fname) or
            util.root_pattern('omnisharp.json')(fname)
    end

    local omnisharp_config = vim.tbl_deep_extend('force', config, {
        handlers = handlers_config,
        on_attach = on_attach,
        organize_imports_on_format = true,
        root_dir = root_dir
    })

    lsp_config.omnisharp.setup(omnisharp_config)
end

return M
