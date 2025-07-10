local M = {}

function M.config()
    local config = {
        use_bundled_binary = true,
        auto_approve = function(params)
            if vim.g.codecompanion_auto_tool_mode == true then
                return true -- Auto approve when CodeCompanion auto-tool mode is on
            end

            if params.server_name == "neovim" then
                return true
            end

            if params.is_auto_approved_in_server then
                return true -- Respect servers.json configuration
            end
            return false
        end,
        builtin_tools = {
            replace_in_file = {
                keymaps = {
                    accept = "ga",
                    reject = "gs",
                },
            },
        },
    }

    -- local features = require("features")
    -- if features.plugin.avante.enabled then
    --     config.extentions = {
    --         avante = {
    --             make_slash_commands = true,
    --         },
    --     }
    -- end

    require("mcphub").setup(config)
    vim.api.nvim_create_autocmd("BufWritePost", {
        pattern = "*",
        callback = function(args)
            local function find_window_by_title(title_pattern)
                for _, win in ipairs(vim.api.nvim_list_wins()) do
                    local buf = vim.api.nvim_win_get_buf(win)
                    local buf_name = vim.api.nvim_buf_get_name(buf)
                    if buf_name:match(title_pattern) then
                        return win
                    end
                end
                return nil
            end
            vim.defer_fn(function()
                local win = find_window_by_title("CodeCompanion")
                if win then
                    vim.api.nvim_win_set_width(win, 60)
                end
            end, 10)
        end,
    })
end

return M
