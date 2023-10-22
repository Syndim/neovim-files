local M = {}

function M.config()
    local languages = require('efmls-configs.defaults').languages()
    local prettier_d = require('efmls-configs.formatters.prettier_d')
    local eslint_d = require('efmls-configs.linters.eslint_d')
    languages = vim.tbl_extend('force', languages, {
        -- Custom languages, or override existing ones
        html = {
            prettier_d,
        },
        python = {
            require('efmls-configs.formatters.autopep8')
        },
        typescriptreact = {
            eslint_d, prettier_d
        },
        typescript = {
            eslint_d, prettier_d
        },
        javascript = {
            eslint_d, prettier_d
        },
        javascriptreact = {
            eslint_d, prettier_d
        }
    })

    local efmls_config = {
        filetypes = vim.tbl_keys(languages),
        settings = {
            rootMarkers = { '.git/' },
            languages = languages,
        },
        init_options = {
            documentFormatting = true,
            documentRangeFormatting = true,
        },
    }

    require('lspconfig').efm.setup(vim.tbl_extend('force', efmls_config, {
        -- Pass your custom lsp config below like on_attach and capabilities
        --
        -- on_attach = on_attach,
        -- capabilities = capabilities,
    }))
end

return M
