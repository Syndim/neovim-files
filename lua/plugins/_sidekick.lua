local M = {}

local sidekick_initialized = false

function M.config()
    local sidekick = require("sidekick")
    local cli = require("sidekick.cli")
    local features = require("features").plugin.sidekick
    local config = {
        nes = {
            enabled = false,
        },
        cli = {
            mux = {
                backend = "tmux",
                enabled = false,
            },
            win = {
                split = {
                    width = 60,
                },
            },
            prompts = {
                git_review = "Review the changes in the latest git commit in details. Provide suggestions about how to improve the code quality. You should include the original code(including line number and the line) and pointing out the issue and provide suggestions about what change needs to be make to improvide the code.",
                add_tests = "Review the changes in the latest git commit in details. Figure out what test casess need to be added or updated to validate the changed logic and prevent regression. Make the code change to add or update those test cases. Keep the test count minimum and do not add replicated test cases.",
            },
        },
    }

    config = vim.tbl_deep_extend("force", config, features.config)
    sidekick.setup(config)

    -- vim.keymap.set("n", "<C-f>", function()
    --     if not sidekick.nes_jump_or_apply() then
    --         local feed = vim.api.nvim_replace_termcodes("<Ignore><C-f>", true, true, true)
    --         vim.api.nvim_feedkeys(feed, "n", false)
    --     end
    -- end, { noremap = true, expr = true, desc = "Goto/Apply Next Edit Suggestion" })

    vim.keymap.set("n", "<Leader>aa", function()
        cli.toggle()
    end, { remap = false, desc = "Sidekick Toggle CLI" })
    vim.keymap.set("n", "<leader>as", function()
        require("sidekick.cli").select({ filter = { insstalled = true } })
    end, { remap = false, desc = "Select CLI" })
    vim.keymap.set({ "x", "n" }, "<leader>at", function()
        require("sidekick.cli").send({ msg = "{this}" })
    end, { remap = false, desc = "Send This" })
    vim.keymap.set({ "x" }, "<leader>av", function()
        require("sidekick.cli").send({ msg = "{selection}" })
    end, { remap = false, desc = "Send Visual Selection" })
    vim.keymap.set({ "n", "x" }, "<leader>ap", function()
        require("sidekick.cli").prompt()
    end, { remap = false, desc = "Sidekick Select Prompt" })
    vim.keymap.set({ "n", "x", "i", "t" }, "<c-.>", function()
        require("sidekick.cli").focus()
    end, { remap = false, desc = "Sidekick Switch Focus" })
    vim.keymap.set("n", "<leader>ao", function()
        require("sidekick.cli").toggle({ name = "opencode", focus = true })
    end, { remap = false, desc = "Sidekick Toggle Opencode" })
    vim.keymap.set("n", "<leader>ac", function()
        require("sidekick.cli").toggle({ name = "copilot", focus = true })
    end, { remap = false, desc = "Sidekick Toggle Github Copilot" })

    sidekick_initialized = true
end

function M.status()
    if sidekick_initialized then
        return ""
    end
    return ""
end

return M
