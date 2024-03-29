local M = {}

function M.config()
    local lsp = require('plugins._lsp')
    local config = lsp.create_config()

    local on_attach = function(client, bufnr)
        config.on_attach(client, bufnr)
        local opts = { remap = false, buffer = bufnr }
        opts.desc = 'Expand macro'
        vim.keymap.set('n', '<leader>em', function() vim.cmd.RustLsp('expandMacro') end, opts)
        opts.desc = 'Rust code action'
        vim.keymap.set('n', '<leader>ca', function() vim.cmd.RustLsp('codeAction') end, opts)
    end

    local features = require('features')

    local default_settings = {
        -- to enable rust-analyzer settings visit:
        -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
        ['rust-analyzer'] = {
            -- enable clippy on save
            -- checkOnSave = {
            --     command = 'clippy'
            -- },
            -- procMacro = {
            --     enable = true
            -- }
        }
    }

    if features.lsp_config['rust'] ~= nil then
        default_settings = vim.tbl_deep_extend('force', default_settings, features.lsp_config['rust'])
    end

    local rust_config = vim.tbl_deep_extend('force', config, {
        standalone = true,
        default_settings = default_settings,
    })

    rust_config.on_attach = on_attach

    vim.g.rustaceanvim = {
        server = rust_config,
        tools = {
            code_actions = {
                ui_select_fallback = true,
            },
        },
    }
end

return M
