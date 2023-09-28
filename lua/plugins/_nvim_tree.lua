local M = {}

function M.config()
    require('nvim-tree').setup({})

    local opts = {
        noremap = true
    }

    vim.api.nvim_set_keymap('', '<F3>', '<cmdNvimTreeToggle<cr>', opts)
    vim.api.nvim_set_keymap('', '<F2>', '<cmd>NvimTreeFindFile<cr>', opts)
end

return M
