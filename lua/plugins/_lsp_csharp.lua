local M = {}

function M.setup(lsp_config, lsp, config)
    local handlers_config = config['handlers']
    if handlers_config == nil then
        handlers_config = {}
    end
    handlers_config['textDocument/definition'] = require('omnisharp_extended').handler

    local default_on_attach = lsp.create_on_attach()
    local function on_attach(client, bufnr)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
            '<cmd>lua require("omnisharp_extended").telescope_lsp_definitions()<CR>', { noremap = true, silent = true })

        -- start issue https://github.com/OmniSharp/omnisharp-roslyn/issues/2483
        -- get the list of tokens from lua =vim.lsp.get_active_clients()[1] and just replace the spaces with underscores
        local tokenModifiers = client.server_capabilities.semanticTokensProvider.legend.tokenModifiers
        for i, v in ipairs(tokenModifiers) do
            tokenModifiers[i] = v:gsub(' ', '_'):gsub('-_', '')
        end
        local tokenTypes = client.server_capabilities.semanticTokensProvider.legend.tokenTypes
        for i, v in ipairs(tokenTypes) do
            tokenTypes[i] = v:gsub(' ', '_'):gsub('-_', '')
        end
        -- end

        default_on_attach(client, bufnr)
    end

    local omnisharp_config = vim.tbl_deep_extend('force', config, {
        handlers = handlers_config,
        on_attach = on_attach
    })

    lsp_config.omnisharp.setup(omnisharp_config)
end

return M

