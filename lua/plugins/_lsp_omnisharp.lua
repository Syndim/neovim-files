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
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua require("omnisharp_extended").telescope_lsp_definitions()<CR>', { noremap = true, silent = true })
    end

    local omnisharp_config = vim.tbl_deep_extend('force', config, {
        handlers = handlers_config,
        on_attach = on_attach
    })

    lsp_config.omnisharp.setup(omnisharp_config)
end

return M