local M = {}

function M.config()
    vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
    vim.fn.sign_define("DiagnosticSignError",
        { text = " ", texthl = "DiagnosticSignError" })
    vim.fn.sign_define("DiagnosticSignWarn",
        { text = " ", texthl = "DiagnosticSignWarn" })
    vim.fn.sign_define("DiagnosticSignInfo",
        { text = " ", texthl = "DiagnosticSignInfo" })
    vim.fn.sign_define("DiagnosticSignHint",
        { text = "", texthl = "DiagnosticSignHint" })

    require("neo-tree").setup({
        window = {
            mappings = {
                ["o"] = "open",
            },
            width = 30
        }
    })

    local opts = {
        noremap = true
    }

    vim.api.nvim_set_keymap('', '<F3>', '<cmd>Neotree toggle<cr>', opts)
    vim.api.nvim_set_keymap('', '<F2>', '<cmd>Neotree reveal_force_cwd<cr>', opts)
end

return M
