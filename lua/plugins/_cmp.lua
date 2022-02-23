local M = {}

function M.config()
    local feedkey = function(key, mode)
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
    end

    -- nvim-cmp setup
    local cmp = require('cmp')
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
                -- show completion source in menu
                format = function(entry, vim_item)
                    vim_item.menu = ({
                        buffer = '[BUF]',
                        nvim_lsp = '[LSP]',
                        path = '[PATH]',
                        crates = '[CRATES]',
                        nvim_lua = '[NVIM]'
                    })[entry.source.name]

                    return vim_item
                end,
        },
        mapping = {
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
        },
        sources = cmp.config.sources({
                { name = 'nvim_lsp' },
                { name = 'path' },
                { name = 'vsnip' },
                { name = "crates" },
                { name = 'buffer' },
                { name = 'nvim_lua' },
                { name = 'nvim_lsp_signature_help' },
        }),
    }

    require('cmp').setup.cmdline('/', {
            sources = {
                { name = 'buffer' }
            }
    })
    require('cmp').setup.cmdline(':', {
            sources = {
                { name = 'cmdline' }
            }
    })
end

return M