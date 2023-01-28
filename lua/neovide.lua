local g = vim.g
local api = vim.api
if not g.neovide then
    return
end

g.neovide_remember_window_size = true

local global = require('global')

if global.is_mac then
    local opts = {
        noremap = true
    }
    api.nvim_set_keymap('n', '˙', '<C-w>h', opts)
    api.nvim_set_keymap('n', '∆', '<C-w>j', opts)
    api.nvim_set_keymap('n', '˚', '<C-w>k', opts)
    api.nvim_set_keymap('n', '¬', '<C-w>l', opts)
    api.nvim_set_keymap('n', 'π', '<cmd>lua require("illuminate").goto_prev_reference()<cr>', opts)
    api.nvim_set_keymap('n', '˜', '<cmd>lua require("illuminate").goto_next_reference()<cr>', opts)
end
