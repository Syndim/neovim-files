local M = {}

function M.config()
    local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end

    local sources = vim.g.cmp_sources or {
        'lazydev',
        'path',
        'crates',
        'buffer',
        'nvim_lua',
        'nvim_lsp_signature_help',
        'npm',
        'tags',
        'treesitter'
    }

    local additional_sources = {}
    for _, source in ipairs(sources) do
        table.insert(additional_sources, { name = source })
    end

    -- nvim-cmp setup
    local cmp = require('cmp')
    local lspkind = require('lspkind')
    -- local global = require('global')
    cmp.setup {
        -- view = {
        -- entries = global.is_windows and 'native' or 'custom',
        -- },
        snippet = {
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end,
        },
        formatting = {
            format = lspkind.cmp_format({
                mode = 'symbol_text',
                maxwidth = 50,
                -- show completion source in menu
                menu = ({
                    nvim_lsp = '[LSP]',
                    vsnip = '[SNIP]',
                    path = '[PATH]',
                    crates = '[CRATES]',
                    buffer = '[BUF]',
                    nvim_lua = '[NVIM]',
                    nvim_lsp_signature_help = '[SIG]',
                    npm = '[NPM]',
                    tags = '[TAGS]',
                    treesitter = '[TS]'
                }),

                -- The function below will be called before any actual modifications from lspkind
                -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
                before = function(entry, vim_item)
                    return vim_item
                end
            })
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.close(),
            ['<CR>'] = cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            },
            ['<Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                elseif vim.fn["vsnip#available"](1) == 1 then
                    feedkey("<Plug>(vsnip-expand-or-jump)", "")
                else
                    fallback()
                end
            end,
            ['<S-Tab>'] = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                    feedkey("<Plug>(vsnip-jump-prev)", "")
                else
                    fallback()
                end
            end,
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' },
        }, additional_sources),
    }

    cmp.setup.cmdline('/', {
        sources = {
            { name = 'buffer' },
            { name = 'nvim_lsp_document_symbol' }
        },
        mapping = cmp.mapping.preset.cmdline({})
    })
    cmp.setup.cmdline(':', {
        sources = {
            { name = 'cmdline' }
        },
        mapping = cmp.mapping.preset.cmdline({})
    })
end

return M
