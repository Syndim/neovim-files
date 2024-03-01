local M = {}

local function create_on_attach()
    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
        local opts = { remap = true, buffer = bufnr }
        -- print('LSP ' .. client.name .. ' attached, setting up key bindings')
        -- Enable completion triggered by <c-x><c-o>
        -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local ts = require('plugins._telescope')
        opts.desc = 'Go to declaration'
        vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
        opts.desc = 'Go to definition'
        vim.keymap.set('n', 'gd', function() ts.builtin.lsp_definitions(ts.dropdown_theme) end, opts)
        opts.desc = 'Find implementations'
        vim.keymap.set('n', 'gi', function() ts.builtin.lsp_implementations(ts.dropdown_theme) end, opts)
        opts.desc = 'Find references'
        vim.keymap.set('n', 'gr', function() ts.builtin.lsp_references(ts.dropdown_theme) end, opts)
        opts.desc = 'Signature help'
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        opts.desc = 'Add workspace folder'
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
        opts.desc = 'Remove workspace folder'
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
        opts.desc = 'List workspace folders'
        vim.keymap.set('n', '<leader>wl',
            function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
        opts.desc = 'Type definition'
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
        opts.desc = 'Rename'
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
        opts.desc = 'Code action'
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        opts.desc = 'Format current document'
        vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, opts)
        opts.desc = 'Document symbols'
        vim.keymap.set('n', '<leader>ds', function() ts.builtin.lsp_document_symbols(ts.dropdown_theme) end,
            opts)
        opts.desc = 'Workspace symbols'
        vim.keymap.set('n', '<leader>ws', function() ts.builtin.lsp_dynamic_workspace_symbols(ts.dropdown_theme) end,
            opts)
    end

    return on_attach
end

local function get_capabilities()
    -- local lsp_status = require('lsp-status')
    -- lsp_status.register_progress()
    local capabilities = require('cmp_nvim_lsp').default_capabilities()
    -- capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }

    return capabilities
end

function M.create_on_attach()
    return create_on_attach()
end

function M.get_capabilities()
    return get_capabilities()
end

function M.create_config()
    -- Mappings.
    -- See `:help vim.diagnostic.*` for documentation on any of the below functions
    local opts = { remap = true }
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

    local on_attach = create_on_attach()
    local capabilities = get_capabilities()

    local config = {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        }
    }

    return config
end

return M
