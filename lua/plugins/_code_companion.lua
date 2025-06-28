local M = {}

-- https://github.com/olimorris/codecompanion.nvim/discussions/813#discussioncomment-12031954
local function setup_fidget_integration()
    local group = vim.api.nvim_create_augroup("CodeCompanionFidgetHooks", {})
    local handles = {}

    local function llm_role_title(adapter)
        local parts = {}
        table.insert(parts, adapter.formatted_name)
        if adapter.model and adapter.model ~= "" then
            table.insert(parts, "(" .. adapter.model .. ")")
        end
        return table.concat(parts, " ")
    end

    local function create_progress_handle(request)
        return require("fidget.progress").handle.create({
            title = " Generating (" .. request.data.strategy .. ")",
            message = "In progress...",
            lsp_client = {
                name = llm_role_title(request.data.adapter),
            },
        })
    end

    local function pop_progress_handle(id)
        local handle = handles[id]
        handles[id] = nil
        return handle
    end

    function report_exit_status(handle, request)
        if request.data.status == "success" then
            handle.message = "Completed"
        elseif request.data.status == "error" then
            handle.message = " Error"
        else
            handle.message = "󰜺 Cancelled"
        end
    end

    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionRequestStarted",
        group = group,
        callback = function(request)
            local handle = create_progress_handle(request)
            handles[request.data.id] = handle
        end,
    })

    vim.api.nvim_create_autocmd({ "User" }, {
        pattern = "CodeCompanionRequestFinished",
        group = group,
        callback = function(request)
            local handle = pop_progress_handle(request.data.id)
            if handle then
                report_exit_status(handle, request)
                handle:finish()
            end
        end,
    })
end

function M.config()
    local features = require("features").plugin.code_companion
    local strategies = {
        chat = {
            adapter = "copilot",
        },
        inline = {
            adapter = "copilot",
        },
    }
    local adapters = nil

    if features.strategies then
        strategies = vim.tbl_deep_extend("force", strategies, features.strategies)
    end
    if features.adapters then
        adapters = {}
        for k, v in pairs(features.adapters) do
            if type(v) == "function" then
                adapters[k] = v
            else
                adapters[k] = function()
                    local extra_config = {
                        schema = {
                            model = {
                                default = v.model,
                            },
                        },
                    }

                    if k == "copilot" then
                        local copilot = require("codecompanion.adapters.copilot")
                        extra_config.handlers = {
                            form_messages = function(self, messages)
                                if #messages >= 1 and messages[#messages].role == "tool" then
                                    self.headers["X-Initiator"] = "agent"
                                else
                                    self.headers["X-Initiator"] = "user"
                                end
                                return copilot.handlers.form_messages(self, messages)
                            end,
                        }
                    end
                    return require("codecompanion.adapters").extend(k, extra_config)
                end
            end
        end
    end

    if features.proxy then
        adapters = adapters or {}
        adapters.opts = {
            allow_insecure = true,
            proxy = features.proxy,
        }
    end

    require("codecompanion").setup({
        strategies = strategies,
        adapters = adapters,
        display = {
            chat = {
                show_settings = true,
                window = {
                    position = "right",
                    width = 0.3,
                },
            },
        },
        extensions = {
            mcphub = {
                callback = "mcphub.extensions.codecompanion",
                opts = {
                    show_result_in_chat = true,
                    make_vars = true,
                    make_slash_commands = true,
                },
            },
        },
    })
    vim.keymap.set("n", "<Leader>cc", function()
        vim.cmd.CodeCompanionChat("Toggle")
    end, { remap = false, desc = "Start new code companion chat" })
    vim.keymap.set("v", "<Leader>cc", ":CodeCompanion<CR>", { remap = false, desc = "Explain selected code" })
    vim.keymap.set("v", "<Leader>cex", function()
        vim.cmd.CodeCompanion("/explain")
    end, { remap = false, desc = "Explain selected code" })
    vim.keymap.set("v", "<Leader>clsp", function()
        vim.cmd.CodeCompanion("/lsp")
    end, { remap = false, desc = "Explain LSP diagnostics for selected code" })
    vim.keymap.set("v", "<Leader>csb", function()
        vim.cmd.CodeCompanion("/buffer")
    end, { remap = false, desc = "Send the current buffer to the LLM as part of an inline prompt" })
    vim.keymap.set("v", "<Leader>cfix", function()
        vim.cmd.CodeCompanion("/fix")
    end, { remap = false, desc = "Fix the selected code" })
    vim.keymap.set("v", "<Leader>ct", function()
        vim.cmd.CodeCompanion("/tests")
    end, { remap = false, desc = "Generate unit tests for selected code" })
    vim.keymap.set("n", "<Leader>cgc", function()
        vim.cmd.CodeCompanion("/commit")
    end, { remap = false, desc = "Generate commit message for staged change" })

    setup_fidget_integration()
end

return M
