local M = {}

function M.config()
    local default_config = require('plugins._lsp').create_config()
    function on_attach(c, bufnr)
        default_config.on_attach(c, bufnr)
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

                    local global = require('global')

                    local function find_buf_by_uri(search_uri)
                        local bufs = vim.api.nvim_list_bufs()
                        for _, buf in ipairs(bufs) do
                            local name = string.gsub(vim.api.nvim_buf_get_name(buf), '\\', '/')
                            if global.is_windows then
                                name = '/' .. name
                            end
                            local uri = "file://" .. name

                            if uri == search_uri then
                                return buf
                            end
                        end
                    end

                    local doc_uri = params.textDocument.uri

                    local target_bufnr = find_buf_by_uri(doc_uri)
                    local line_count = vim.api.nvim_buf_line_count(target_bufnr)
                    local last_line = vim.api.nvim_buf_get_lines(target_bufnr, line_count - 1, line_count,
                        true)[1]

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
                        },
                        handler,
                        req_bufnr
                    )
                end
            end
        end
        semantic_tokens(c)
    end

    local config = vim.tbl_deep_extend('force', default_config, {
        on_attach = on_attach,
        settings = {
            ['csharp|navigation'] = {
                dotnet_navigate_to_decompiled_sources = true,
            },
            ['csharp|symbol_search'] = {
                dotnet_search_reference_assemblies = true,
            },
            ['csharp|quick_info'] = {
                dotnet_show_remarks_in_quick_info = true,
            },
            ['csharp|highlighting'] = {
                dotnet_highlight_related_json_components = true,
                dotnet_highlight_related_regex_components = true,
            },

            ['csharp|completion'] = {
                dotnet_provide_regex_completions = true,
                dotnet_show_completion_items_from_unimported_namespaces = true,
                dotnet_show_name_completion_suggestions = true,
            },
            ['csharp|code_lens'] = {
                dotnet_enable_references_code_lens = true,
                dotnet_enable_tests_code_lens = true,
            },
            ['csharp|inlay_hints'] = {
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

    require('roslyn').setup({
        config = config,
        filewatching = true,
    })

    vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
        pattern = '*.cs',
        callback = function()
            local clients = vim.lsp.get_clients({ name = 'roslyn' })
            if not clients or #clients == 0 then
                return
            end

            local buffers = vim.lsp.get_buffers_by_client_id(clients[1].id)
            for _, buf in ipairs(buffers) do
                vim.lsp.util._refresh('textDocument/diagnostic', { bufnr = buf })
            end
        end,
    })
end

return M
