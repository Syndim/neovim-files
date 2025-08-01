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
        -- local fzf = require("fzf-lua")
        opts.desc = "Go to declaration"
        vim.keymap.set("n", "gD", function()
            vim.lsp.buf.declaration()
        end, opts)
        opts.desc = "Go to definition"
        vim.keymap.set("n", "gd", function()
            -- fzf.lsp_definitions()
            vim.cmd.Telescope("lsp_definitions", "theme=dropdown")
        end, opts)
        opts.desc = "Find implementations"
        vim.keymap.set("n", "gi", function()
            -- fzf.lsp_implementations()
            vim.cmd.Telescope("lsp_implementations", "theme=dropdown")
        end, opts)
        opts.desc = "Find references"
        vim.keymap.set("n", "gr", function()
            -- fzf.lsp_references()
            vim.cmd.Telescope("lsp_references", "theme=dropdown")
        end, opts)
        opts.desc = "Signature help"
        vim.keymap.set("n", "<leader>hs", vim.lsp.buf.signature_help, opts)
        opts.desc = "Add workspace folder"
        vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
        opts.desc = "Remove workspace folder"
        vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
        opts.desc = "List workspace folders"
        vim.keymap.set("n", "<leader>wl", function()
            vim.lsp.buf.list_workspace_folders()
        end, opts)
        opts.desc = "Type definition"
        vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
        opts.desc = "Rename"
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        opts.desc = "Code action"
        -- vim.keymap.set("n", "<leader>ca", function()
        -- 	fzf.lsp_code_actions()
        -- end, opts)
        -- vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "<leader>ca", require("actions-preview").code_actions, opts)
        opts.desc = "Format current document"
        -- vim.keymap.set('n', '<leader>ff', vim.lsp.buf.format, opts)
        vim.keymap.set("n", "<leader>ff", function()
            require("conform").format({ async = true })
        end, opts)
        opts.desc = "Document symbols"
        vim.keymap.set("n", "<leader>ds", function()
            -- fzf.lsp_document_symbols()
            vim.cmd.Telescope("lsp_document_symbols", "theme=dropdown")
        end, opts)
        opts.desc = "Workspace symbols"
        vim.keymap.set("n", "<leader>ws", function()
            -- fzf.lsp_live_workspace_symbols()
            vim.cmd.Telescope("lsp_dynamic_workspace_symbols", "theme=dropdown")
        end, opts)
        if
            client.supports_method("textDocument/inlayHint")
            or client.server_capabilities.inlayHintProvider
            or client.name == "sourcekit"
        then
            vim.lsp.inlay_hint.enable(true, {
                -- bufnr = bufnr,
            })
        end
    end

    return on_attach
end

local function get_capabilities()
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = vim.tbl_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
    --

    local capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)

    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
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
    vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump(1)
    end, opts)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump(-1)
    end, opts)
    vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

    local on_attach = create_on_attach()
    local capabilities = get_capabilities()

    local config = {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            -- This will be the default in neovim 0.7+
            debounce_text_changes = 150,
        },
    }

    for k, default_handler in pairs(vim.lsp.handlers) do
        vim.lsp.handlers[k] = function(err, result, context, conf)
            -- work around for the server request cancel issue
            -- -- TODO: Remove this work around after neovim 0.11 is released
            -- if err ~= nil and err.code == -32802 then
            -- 	return
            -- end
            -- work around for the sourcekit timeout issue
            -- https://github.com/swiftlang/sourcekit-lsp/issues/2021
            if err ~= nil and err.code == -32001 then
                -- print(vim.inspect(context))
                return
            end
            -- Work around for invalid offset error
            -- https://github.com/rust-lang/rust-analyzer/issues/17289
            if err ~= nil and err.code == -32603 then
                return
            end
            return default_handler(err, result, context, conf)
        end
    end
    -- vim.lsp.set_log_level('INFO')
    return config
end

return M
