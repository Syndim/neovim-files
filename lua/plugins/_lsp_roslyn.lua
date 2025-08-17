local M = {}

function M.setup(config)
    local function on_attach(c, bufnr)
        config.on_attach(c, bufnr)
        local function semantic_tokens(client)
            if not client.is_hacked_roslyn then
                client.is_hacked_roslyn = true

                -- let the runtime know the server can do semanticTokens/full now
                if client.server_capabilities.semanticTokensProvider then
                    client.server_capabilities = vim.tbl_deep_extend("force", client.server_capabilities, {
                        semanticTokensProvider = {
                            full = true,
                        },
                    })
                end

                -- -- monkey patch the request proxy
                local request_inner = client.request
                client.request = function(method, params, handler, req_bufnr)
                    if method ~= vim.lsp.protocol.Methods.textDocument_semanticTokens_full then
                        return request_inner(method, params, handler, req_bufnr)
                    end

                    local target_bufnr = vim.uri_to_bufnr(params.textDocument.uri)
                    local line_count = vim.api.nvim_buf_line_count(target_bufnr)
                    local last_line = vim.api.nvim_buf_get_lines(target_bufnr, line_count - 1, line_count, true)[1]

                    return request_inner("textDocument/semanticTokens/range", {
                        textDocument = params.textDocument,
                        range = {
                            ["start"] = {
                                line = 0,
                                character = 0,
                            },
                            ["end"] = {
                                line = line_count - 1,
                                character = string.len(last_line) - 1,
                            },
                        },
                    }, handler, req_bufnr)
                end
            end
        end
        -- semantic_tokens(c)
    end

    local roslyn_config = vim.tbl_deep_extend("force", config, {
        on_attach = on_attach,
        single_file_support = false,
        settings = {
            ["csharp|background_analysis"] = {
                dotnet_compiler_diagnostics_scope = "fullSolution",
            },
            ["csharp|navigation"] = {
                dotnet_navigate_to_decompiled_sources = true,
            },
            ["csharp|symbol_search"] = {
                dotnet_search_reference_assemblies = true,
            },
            ["csharp|quick_info"] = {
                dotnet_show_remarks_in_quick_info = true,
            },
            ["csharp|highlighting"] = {
                dotnet_highlight_related_json_components = true,
                dotnet_highlight_related_regex_components = true,
            },

            ["csharp|completion"] = {
                dotnet_provide_regex_completions = true,
                dotnet_show_completion_items_from_unimported_namespaces = true,
                dotnet_show_name_completion_suggestions = true,
            },
            ["csharp|code_lens"] = {
                dotnet_enable_references_code_lens = true,
                dotnet_enable_tests_code_lens = true,
            },
            ["csharp|inlay_hints"] = {
                csharp_enable_inlay_hints_for_implicit_object_creation = true,
                csharp_enable_inlay_hints_for_implicit_variable_types = true,
                csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                csharp_enable_inlay_hints_for_types = true,
                dotnet_enable_inlay_hints_for_indexer_parameters = true,
                dotnet_enable_inlay_hints_for_literal_parameters = true,
                dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                dotnet_enable_inlay_hints_for_other_parameters = true,
                dotnet_enable_inlay_hints_for_parameters = true,
            },
        },
    })

    -- For some reason if we set capabilities, there are chances that it will freeze neovim
    -- roslyn_config.capabilities = nil

    vim.lsp.config("roslyn", roslyn_config)

    vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        pattern = "*.cs",
        callback = function()
            local clients = vim.lsp.get_clients({ name = "roslyn" })
            if not clients or #clients == 0 then
                return
            end

            local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
            for _, buf in ipairs(buffers) do
                vim.lsp.util._refresh("textDocument/diagnostic", { bufnr = buf })
            end
        end,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            local bufnr = args.buf

            if client and (client.name == "roslyn" or client.name == "roslyn_ls") then
                vim.api.nvim_create_autocmd("InsertCharPre", {
                    desc = "Roslyn: Trigger an auto insert on '/'.",
                    buffer = bufnr,
                    callback = function()
                        local char = vim.v.char

                        if char ~= "/" then
                            return
                        end

                        local row, col = unpack(vim.api.nvim_win_get_cursor(0))
                        row, col = row - 1, col + 1
                        local uri = vim.uri_from_bufnr(bufnr)

                        local params = {
                            _vs_textDocument = { uri = uri },
                            _vs_position = { line = row, character = col },
                            _vs_ch = char,
                            _vs_options = {
                                tabSize = vim.bo[bufnr].tabstop,
                                insertSpaces = vim.bo[bufnr].expandtab,
                            },
                        }

                        -- NOTE: We should send textDocument/_vs_onAutoInsert request only after
                        -- buffer has changed.
                        vim.defer_fn(function()
                            client:request(
                                ---@diagnostic disable-next-line: param-type-mismatch
                                "textDocument/_vs_onAutoInsert",
                                params,
                                function(err, result, _)
                                    if err or not result then
                                        return
                                    end

                                    vim.snippet.expand(result._vs_textEdit.newText)
                                end,
                                bufnr
                            )
                        end, 1)
                    end,
                })
            end
        end,
    })
end

function M.config()
    require("roslyn").setup({})
end

return M
