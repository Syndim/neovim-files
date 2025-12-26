local M = {}

function M.config()
    -- mini.indentscope
    -- vim.api.nvim_create_autocmd("FileType", {
    -- 	pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
    -- 	callback = function()
    -- 		vim.b.miniindentscope_disable = true
    -- 	end,
    -- })
    -- local opts = {
    -- 	symbol = "│",
    -- 	options = { try_as_border = true },
    -- }
    --
    -- require("mini.indentscope").setup(opts)

    -- mini.surround
    require("mini.surround").setup({
        mappings = {
            add = "coa", -- Add surrounding in Normal and Visual modes
            delete = "cod", -- Delete surrounding
            find = "cof", -- Find surrounding (to the right)
            find_left = "coF", -- Find surrounding (to the left)
            highlight = "coh", -- Highlight surrounding
            replace = "cor", -- Replace surrounding
            update_n_lines = "con", -- Update `n_lines`
        },
    })

    -- mini.comment
    require("mini.comment").setup()

    -- mini.trailspace
    require("mini.trailspace").setup()
    local opts = { remap = false }
    opts.desc = "Remove trailing whitespace"
    vim.keymap.set("n", "<leader>cl", function()
        MiniTrailspace.trim()
        MiniTrailspace.trim_last_lines()
    end, opts)

    -- mini.pairs
    -- require("mini.pairs").setup({
    --     modes = {
    --         insert = true,
    --         command = true,
    --         terminal = true,
    --     },
    -- })

    -- mini.diff
    -- require("mini.diff").setup({
    --     mappings = {
    --         apply = "ga",
    --         reset = "gs",
    --     },
    -- })

    -- mini.move
    -- Alt+h/l/j/k to move line in normal mode or block in visual mode
    require("mini.move").setup({
        mappings = {
            left = "<C-h>",
            right = "<C-l>",
            up = "<C-k>",
            down = "<C-j>",

            line_left = "<C-h>",
            line_right = "<C-l>",
            line_up = "<C-k>",
            line_down = "<C-j>",
        },
    })

    -- mini.ai, enhanced textobject for 'a' and 'i'
    require("mini.ai").setup()
end

return M
