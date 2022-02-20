local M = {}

function brew_or_scoop(package_win, package_non_win)
    local global = require('global')
    if not package_non_win then
        package_non_win = package_win
    end

    if global.is_windows then
        return 'scoop install ' .. package_win
    else
        return 'brew install ' .. package_non_win
    end
end

function npm(package)
    return 'npm install -g ' .. package
end

servers = {
    clangd = {
        install = brew_or_scoop('llvm')
    },
    pyright = {
        install = npm('pyright')
    },
    rust_analyzer = {
        install = brew_or_scoop('rust-analyzer')
    },
    tsserver = {
        install = npm('typescript typescript-language-server')
    },
    dartls = {
        config = {
            cmd = { 'dart', 'language-server' }
        }
    },
    solargraph = {
        install = 'gem install --user-install solargraph'
    },
    sumneko_lua = {
        install = brew_or_scoop('lua-language-server')
    },
    html = {
        install = npm('vscode-langservers-extracted')
    },
    cssls = {
        install = npm('vscode-langservers-extracted')
    },
    dockerls = {
        install = npm('dockerfile-language-server-nodejs')
    },
    jsonls = {
        install = npm('vscode-langservers-extracted')
    }
}

function exec_install(table, index)
    local next_index = next(table, index)
    local cfg = table[next_index]

    if cfg then
        local cmd = cfg.install
        if cmd then
            print('Installing LSP ' .. next_index)
            local os = require('os')
            local global = require('global')
            local suffix = global.is_windows and ' >nul 2>nul' or ' &> /dev/null'
            os.execute(cmd .. suffix)
            exec_install(table, next_index)
        else
            print('Skip install LSP ' .. next_index)
            exec_install(table, next_index)
        end
    else
        print('Done')
    end
end

function M.install()
    exec_install(servers, nil)
end

function M.config()
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
    end


    local lsp_status = require('lsp-status')
    lsp_status.register_progress()

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
    capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

    local lspconfig = require('lspconfig')

    base_config = {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }

    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    for lsp, server in pairs(servers) do
        local config = base_config
        if server.config then
            config = vim.tbl_extend('force', base_config, server.config)
        end
        lspconfig[lsp].setup(config)
    end

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
