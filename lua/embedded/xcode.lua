if not vim.g.shadowvim then
    return
end

local api = vim.api
local opts = {
    noremap = true
}
api.nvim_set_keymap('n', 'gd', '<Cmd>SVPress <LT>C-D-j><CR>', opts)
api.nvim_set_keymap('n', 'gr', '<Cmd>SVPress <LT>C-S-D-f><CR>', opts)
api.nvim_set_keymap('n', 'K', '<Cmd>SVPress <LT>M-LeftMouse><CR>', opts)
api.nvim_set_keymap('n', '<C-o>', '<Cmd>SVPress <LT>C-D-Left><CR>', opts)
api.nvim_set_keymap('n', '<C-i>', '<Cmd>SVPress <LT>C-D-Right><CR>', opts)
api.nvim_set_keymap('n', 'zz', '<Cmd>SVPress <LT>C-M-S-D-l><CR>', opts)
